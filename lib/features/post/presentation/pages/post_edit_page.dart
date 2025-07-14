import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

/// 게시글 작성/수정 공통 폼 페이지
///
/// - 상태/로직은 Provider로 분리 권장(현재는 StatefulWidget)
/// - 공통 위젯(AppLoadingView, AppErrorView 등) 사용 권장
/// - 컬러/문구/패딩 등은 core/constants로 상수화 권장
class PostEditPage extends StatefulWidget {
  /// 수정 모드 여부
  final bool isEdit;
  /// 수정할 게시글 ID (수정 모드일 때만 사용)
  final String? postId;
  /// 생성자
  const PostEditPage({super.key, this.isEdit = false, this.postId});

  @override
  State<PostEditPage> createState() => _PostEditPageState();
}

class _PostEditPageState extends State<PostEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _youtubeController = TextEditingController();
  String _category = '자유';
  bool _isLoading = false;

  final List<String> _categories = ['자유', '밴드', '영상'];

  // 썸네일 동적 반영용
  String? _youtubeThumb;
  final Random _random = Random();
  late final String _picsumUrl;

  @override
  void initState() {
    super.initState();
    _picsumUrl = 'https://picsum.photos/seed/${_random.nextInt(1000) + 1}/800/420';
    _youtubeController.addListener(_updateYoutubeThumb);
    if (widget.isEdit && widget.postId != null) {
      _loadPost();
    } else {
      _updateYoutubeThumb();
    }
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

  /// 기존 게시글 데이터 불러오기 (수정 모드)
  Future<void> _loadPost() async {
    setState(() => _isLoading = true);
    try {
      final DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance.collection('posts').doc(widget.postId).get();
      final Map<String, dynamic>? data = doc.data();
      if (data != null) {
        _titleController.text = data['title'] ?? '';
        _contentController.text = data['content'] ?? '';
        _youtubeController.text = data['youtubeUrl'] ?? '';
        _category = data['category'] ?? '자유';
        _updateYoutubeThumb();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('게시글 정보를 불러오지 못했습니다.')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// 게시글 저장(수정/작성)
  Future<void> _savePost() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final Map<String, dynamic> data = {
        'title': _titleController.text.trim(),
        'content': _contentController.text.trim(),
        'youtubeUrl': _youtubeController.text.trim(),
        'category': _category,
        'updatedAt': FieldValue.serverTimestamp(),
      };
      if (widget.isEdit && widget.postId != null) {
        await FirebaseFirestore.instance.collection('posts').doc(widget.postId).update(data);
      } else {
        // 신규 작성(추후 구현)
      }
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('게시글 저장에 실패했습니다.')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isEdit ? '게시글 수정' : '게시글 작성')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.zero,
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
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.35),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextFormField(
                                controller: _titleController,
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                                  contentPadding: EdgeInsets.zero,
                                ),
                                validator: (v) => v == null || v.trim().isEmpty ? '제목을 입력해 주세요.' : null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // 본문, 카테고리, 유튜브, 기타 입력
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _contentController,
                            decoration: const InputDecoration(labelText: '내용'),
                            maxLines: 6,
                            validator: (v) => v == null || v.trim().isEmpty ? '내용을 입력해 주세요.' : null,
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: _category,
                            items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                            onChanged: (v) => setState(() => _category = v ?? '자유'),
                            decoration: const InputDecoration(labelText: '카테고리'),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _youtubeController,
                            decoration: const InputDecoration(labelText: '유튜브 링크(선택)'),
                          ),
                          // 기타 링크 입력 필드 필요시 여기에 추가
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _savePost,
                              child: Text(widget.isEdit ? '수정 완료' : '등록'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
} 