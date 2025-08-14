import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/app_logger.dart';
import '../../../../../core/constants/post_constants.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/repositories/post_repository.dart';
import '../../../domain/use_cases/create_post.dart';
import '../states/post_write_state.dart';

/// 게시글 작성 페이지의 비즈니스 로직을 담당하는 StateNotifier
class PostWriteNotifier extends StateNotifier<PostWriteState> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController youtubeController = TextEditingController();

  final Random _random = Random();
  late final String _backgroundImage;
  final PostRepository _postRepository;

  // 카테고리 목록
  final List<String> categories = PostConstants.categories.where((c) => c != PostConstants.allCategory).toList();

  PostWriteNotifier({required PostRepository postRepository})
      : _postRepository = postRepository,
        super(const PostWriteState(
        category: PostConstants.defaultCategory,
        isLoading: false, // 초기 로딩 상태를 false로 변경
        youtubeThumb: null,
        backgroundImage: 'https://picsum.photos/seed/2/800/420', // 기본 이미지로 초기화
      )) {
    // 생성자에서 배경 이미지 생성
    _backgroundImage = 'https://picsum.photos/seed/${_random.nextInt(1000) + 1}/800/420';
    state = state.copyWith(
      backgroundImage: _backgroundImage,
    );
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

  /// 이미지 추가
  void addImage(String imageUrl) {
    final currentImages = List<String>.from(state.imageUrls);
    currentImages.add(imageUrl);
    state = state.copyWith(imageUrls: currentImages);
  }

  /// 이미지 제거
  void removeImage(String imageUrl) {
    final currentImages = List<String>.from(state.imageUrls);
    currentImages.remove(imageUrl);
    state = state.copyWith(imageUrls: currentImages);
  }

  /// 이미지 목록 설정
  void setImages(List<String> imageUrls) {
    state = state.copyWith(imageUrls: imageUrls);
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

      // 디버깅: 사용자 데이터 로그
      AppLogger.i('사용자 데이터: $userData');
      AppLogger.i('사용자 닉네임: ${userData['nickname']}');
      AppLogger.i('사용자 프로필 이미지: ${userData['profileImageUrl']}');

      // Post 엔티티 생성
      final post = Post.create(
        authorId: user.uid,
        authorNickname: userData['nickname'] ?? '',
        authorProfileUrl: userData['profileImageUrl'] ?? '',
        title: titleController.text.trim(),
        content: contentController.text.trim(),
        category: state.category,
        imageUrls: state.imageUrls,
        youtubeUrl: youtubeController.text.trim(),
        backgroundImage: state.backgroundImage,
      );

      // 디버깅: 생성된 Post 엔티티 로그
      AppLogger.i('생성된 Post 엔티티: ${post.toString()}');

      // UseCase를 통해 게시글 생성
      final createPost = CreatePost(repository: _postRepository);

      final result = await createPost(
        authorId: post.authorId,
        authorNickname: post.authorNickname,
        authorProfileUrl: post.authorProfileUrl,
        title: post.title,
        content: post.content,
        category: post.category,
        youtubeUrl: post.youtubeUrl,
        backgroundImage: post.backgroundImage,
      );

      // 디버깅: UseCase 결과 로그
      AppLogger.i('UseCase 결과: $result');

      return result.fold(
            (failure) {
          AppLogger.e('게시글 생성 실패: ${failure.message}');
          state = state.copyWith(error: failure.message);
          return false;
        },
            (createdPost) {
          AppLogger.i('게시글 생성 성공: ${createdPost.toString()}');
          // 성공 시 상태 업데이트 및 true 반환
          state = state.copyWith(error: null);
          return true;
        },
      );
    } catch (e, stackTrace) {
      AppLogger.e('게시글 등록 중 예외 발생: $e');
      AppLogger.e('스택 트레이스: $stackTrace');
      state = state.copyWith(error: e.toString());
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}