import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

/// 게시글 작성 페이지의 상태
class PostWriteState {
  final String category;
  final bool isLoading;
  final String? youtubeThumb;
  final String picsumUrl;
  final String? error;

  const PostWriteState({
    required this.category,
    required this.isLoading,
    required this.youtubeThumb,
    required this.picsumUrl,
    this.error,
  });

  PostWriteState copyWith({
    String? category,
    bool? isLoading,
    String? youtubeThumb,
    String? picsumUrl,
    String? error,
  }) {
    return PostWriteState(
      category: category ?? this.category,
      isLoading: isLoading ?? this.isLoading,
      youtubeThumb: youtubeThumb ?? this.youtubeThumb,
      picsumUrl: picsumUrl ?? this.picsumUrl,
      error: error ?? this.error,
    );
  }
}

/// 게시글 작성 페이지의 비즈니스 로직을 담당하는 StateNotifier
class PostWriteNotifier extends StateNotifier<PostWriteState> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController youtubeController = TextEditingController();
  
  final Random _random = Random();
  late final String _picsumUrl;

  // 카테고리 목록
  final List<String> categories = ['자유', '밴드', '영상'];

  PostWriteNotifier() : super(const PostWriteState(
    category: '자유',
    isLoading: false,
    youtubeThumb: null,
    picsumUrl: '',
  )) {
    _picsumUrl = 'https://picsum.photos/seed/${_random.nextInt(1000) + 1}/800/420';
    state = state.copyWith(picsumUrl: _picsumUrl);
    youtubeController.addListener(_updateYoutubeThumb);
    _updateYoutubeThumb();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    youtubeController.removeListener(_updateYoutubeThumb);
    youtubeController.dispose();
    super.dispose();
  }

  /// 카테고리 변경
  void setCategory(String category) {
    state = state.copyWith(category: category);
  }

  /// 유튜브 썸네일 동적 반영
  void _updateYoutubeThumb() {
    final youtubeThumb = _getYoutubeThumbnail(youtubeController.text.trim());
    state = state.copyWith(youtubeThumb: youtubeThumb);
  }

  /// 유튜브 썸네일 URL 추출
  /// [url] : 유튜브 URL
  /// return : 썸네일 이미지 URL
  String? _getYoutubeThumbnail(String? url) {
    if (url == null || url.isEmpty) return null;
    final Uri? uri = Uri.tryParse(url);
    if (uri == null || !uri.host.contains('youtu')) return null;
    final String? videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : null;
    if (videoId == null || videoId.length < 5) return null;
    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }

  /// 게시글 등록
  Future<bool> submitPost() async {
    if (titleController.text.trim().isEmpty || contentController.text.trim().isEmpty) {
      return false;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('로그인 필요');

      final DocumentSnapshot<Map<String, dynamic>> userDoc = 
          await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      final Map<String, dynamic> userData = userDoc.data() ?? {};

      await FirebaseFirestore.instance.collection('posts').add({
        'title': titleController.text.trim(),
        'content': contentController.text.trim(),
        'youtubeUrl': youtubeController.text.trim(),
        'category': state.category,
        'authorId': user.uid,
        'authorNickname': userData['nickname'] ?? '',
        'authorProfileUrl': userData['profileImageUrl'] ?? '',
        'likes': [],
        'likesCount': 0,
        'isNotice': false,
        'isDeleted': false,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

/// PostWriteNotifier의 Provider
final postWriteProvider = StateNotifierProvider<PostWriteNotifier, PostWriteState>(
  (ref) => PostWriteNotifier(),
); 