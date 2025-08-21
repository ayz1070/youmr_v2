import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youmr_v2/core/constants/post_constants.dart';
import 'package:youmr_v2/core/widgets/primary_app_bar.dart';
import 'package:youmr_v2/core/widgets/app_loading_view.dart';
import '../widgets/post_header_image.dart';
import '../widgets/post_form_inputs.dart';
import 'dart:math';

/// 게시글 작성/수정 공통 폼 페이지
///
/// - PostWritePage와 동일한 UI 스타일 적용
/// - PostHeaderImage와 PostFormInputs 위젯 재사용
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
  String _category = PostConstants.defaultCategory;
  bool _isLoading = false;

  final List<String> _categories = PostConstants.categories.where((c) => c != PostConstants.allCategory).toList();

  // 썸네일 동적 반영용
  String? _youtubeThumb;
  final Random _random = Random();
  late String _picsumUrl;

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
        _category = data['category'] ?? PostConstants.defaultCategory;
        
        // 수정 모드에서는 기존 이미지 유지 (picsumUrl을 postId 기반으로 설정)
        if (widget.isEdit && widget.postId != null) {
          final int picsumId = widget.postId!.hashCode.abs() % 1000;
          _picsumUrl = 'https://picsum.photos/seed/$picsumId/800/420';
        }
        
        _updateYoutubeThumb();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('게시글 정보를 불러오지 못했습니다.')),
        );
      }
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
        // 수정 모드
        await FirebaseFirestore.instance.collection('posts').doc(widget.postId).update(data);
        
        if (mounted) {
          Navigator.of(context).pop(true);
          
          // 성공 메시지 표시
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('게시글이 수정되었습니다.')),
          );
        }
      } else {
        // 신규 작성(추후 구현)
        if (mounted) {
          Navigator.of(context).pop(true);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('게시글 저장에 실패했습니다: ${e.toString()}')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: widget.isEdit ? "게시글 수정" : "게시글 작성",
      ),
      body: _isLoading
          ? const AppLoadingView()
          : SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 헤더 이미지와 제목 입력 (PostWritePage와 동일)
                      PostHeaderImage(
                        youtubeThumb: _youtubeThumb,
                        backgroundImage: _picsumUrl, // picsumUrl을 backgroundImage로 전달
                        titleController: _titleController,
                        validator: (v) => v == null || v.trim().isEmpty ? '제목을 입력해 주세요.' : null,
                      ),
                      
                      // 폼 입력 필드들 (PostWritePage와 동일)
                      PostFormInputs(
                        contentController: _contentController,
                        youtubeController: _youtubeController,
                        category: _category,
                        categories: _categories,
                        onCategoryChanged: (category) => setState(() => _category = category ?? PostConstants.defaultCategory),
                        onSubmit: _savePost,
                        isLoading: _isLoading,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
} 