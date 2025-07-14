import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

import '../../../main/presentation/pages/main_navigation_page.dart';

/// 글쓰기(게시글 작성) 페이지
///
/// - 상태/로직은 Provider로 분리 권장(현재는 StatefulWidget)
/// - 공통 위젯(AppLoadingView, AppErrorView 등) 사용 권장
/// - 컬러/문구/패딩 등은 core/constants로 상수화 권장
class WritePage extends StatefulWidget {
  /// 생성자
  const WritePage({super.key});

  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _youtubeController = TextEditingController();
  String _category = '자유';
  bool _isLoading = false;

  final List<String> _categories = ['자유', '신청곡', '영상'];

  // 썸네일 동적 반영용
  String? _youtubeThumb;
  final Random _random = Random();
  late final String _picsumUrl;

  @override
  void initState() {
    super.initState();
    _picsumUrl = 'https://picsum.photos/seed/${_random.nextInt(1000) + 1}/800/420';
    _youtubeController.addListener(_updateYoutubeThumb);
    _updateYoutubeThumb();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _youtubeController.removeListener(_updateYoutubeThumb);
    _youtubeController.dispose();
    super.dispose();
  }

  /// 유튜브 썸네일 동적 반영
  void _updateYoutubeThumb() {
    setState(() {
      _youtubeThumb = getYoutubeThumbnail(_youtubeController.text.trim());
    });
  }

  /// 유튜브 썸네일 URL 추출
  /// [url] : 유튜브 URL
  /// return : 썸네일 이미지 URL
  String? getYoutubeThumbnail(String? url) {
    if (url == null) return null;
    final Uri? uri = Uri.tryParse(url);
    if (uri == null || !uri.host.contains('youtu')) return null;
    final String? videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : null;
    if (videoId == null || videoId.length < 5) return null;
    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }

  /// 게시글 등록
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('로그인 필요');
      final DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      final Map<String, dynamic> userData = userDoc.data() ?? {};
      await FirebaseFirestore.instance.collection('posts').add({
        'title': _titleController.text.trim(),
        'content': _contentController.text.trim(),
        'youtubeUrl': _youtubeController.text.trim(),
        'category': _category,
        'authorId': user.uid,
        'authorNickname': userData['nickname'] ?? '',
        'authorProfileUrl': userData['profileImageUrl'] ?? '',
        'likes': [],
        'likesCount': 0,
        'isNotice': false,
        'isDeleted': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const MainNavigationPage(),
            settings: const RouteSettings(arguments: {'showPostSuccess': true}),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('게시글 등록에 실패했습니다.')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 상단 이미지 + 제목 입력
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.zero,
                            child: (_youtubeThumb != null)
                                ? Image.network(
                                    _youtubeThumb!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 340,
                                    loadingBuilder: (context, child, progress) => progress == null
                                        ? child
                                        : Container(
                                            color: Colors.grey[300],
                                            width: double.infinity,
                                            height: 340,
                                          ),
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      color: Colors.grey[300],
                                      width: double.infinity,
                                      height: 340,
                                      child: Icon(Icons.image_not_supported, size: 48, color: Colors.grey[500]),
                                    ),
                                  )
                                : Image.network(
                                    _picsumUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 340,
                                    loadingBuilder: (context, child, progress) => progress == null
                                        ? child
                                        : Container(
                                            color: Colors.grey[300],
                                            width: double.infinity,
                                            height: 340,
                                          ),
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      color: Colors.grey[300],
                                      width: double.infinity,
                                      height: 340,
                                      child: Icon(Icons.image_not_supported, size: 48, color: Colors.grey[500]),
                                    ),
                                  ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 32,
                            child: Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: TextFormField(
                                  controller: _titleController,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 22,
                                        shadows: [Shadow(color: Colors.black38, blurRadius: 4)],
                                      ),
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '제목을 입력하세요',
                                    hintStyle: TextStyle(color: Colors.white70),
                                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                                  ),
                                  validator: (v) => v == null || v.trim().isEmpty ? '제목을 입력해 주세요.' : null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // 본문, 카테고리, 유튜브, 기타 입력
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 32, 18, 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              controller: _contentController,
                              decoration: const InputDecoration(
                                labelText: '내용',
                                border: InputBorder.none,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black12),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black54, width: 1.5),

                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 12),
                              ),
                              maxLines: 6,
                              validator: (v) => v == null || v.trim().isEmpty ? '내용을 입력해 주세요.' : null,
                            ),
                            const SizedBox(height: 16),
                            DropdownButtonFormField<String>(
                              value: _category,
                              items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                              onChanged: (v) => setState(() => _category = v ?? '자유'),
                              decoration: const InputDecoration(
                                labelText: '카테고리',
                                border: InputBorder.none,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black12),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black54, width: 1.5),
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _youtubeController,
                              decoration: const InputDecoration(
                                labelText: '유튜브 링크(선택)',
                                border: InputBorder.none,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black12),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black54, width: 1.5),
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                            const SizedBox(height: 32),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _submit,
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  elevation: 0,
                                ),
                                child: const Text('등록', style: TextStyle(fontSize: 18)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
} 