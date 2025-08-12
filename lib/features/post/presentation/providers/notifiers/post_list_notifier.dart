import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/post_constants.dart';
import '../../../../../core/errors/app_failure.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/use_cases/get_notices_use_case.dart';
import '../../../domain/use_cases/get_posts_stream_use_case.dart';
import '../states/post_list_state.dart';

class PostListNotifier extends StateNotifier<PostListState> {
  final GetPostsStreamUseCase _getPostsStream;
  final GetNoticesUseCase _getNotices;
  String _currentCategory = PostConstants.allCategory;
  StreamSubscription<Either<AppFailure, List<Post>>>? _postsSubscription;

  /// 생성자
  PostListNotifier({
    required GetPostsStreamUseCase getPostsStream,
    required GetNoticesUseCase getNotices,
  })  : _getPostsStream = getPostsStream,
        _getNotices = getNotices,
        super(PostListState.initial()) {
    // 초기 데이터 로드
    _loadPosts();
  }

  /// 카테고리 변경
  void changeCategory(String category) {
    _currentCategory = category;
    _loadPosts();
  }

  /// 게시글 목록 로드 (실시간 스트림)
  void _loadPosts() {
    // 기존 구독 해제
    _postsSubscription?.cancel();

    state = state.copyWith(isLoading: true, error: null);

    // 공지글 로드
    _loadNotices();

    // 일반 게시글 실시간 스트림 구독
    _postsSubscription = _getPostsStream(
      category: _currentCategory == PostConstants.allCategory ? null : _currentCategory,
      limit: 20,
    ).listen(
          (result) {
        result.fold(
              (failure) {
            state = state.copyWith(
              isLoading: false,
              error: failure.message,
            );
          },
              (posts) {
            state = state.copyWith(
              posts: posts,
              isLoading: false,
              error: null,
            );
          },
        );
      },
      onError: (error) {
        state = state.copyWith(
          isLoading: false,
          error: error.toString(),
        );
      },
    );
  }

  /// 공지글 로드
  Future<void> _loadNotices() async {
    try {
      final result = await _getNotices(limit: 3);
      result.fold(
            (failure) {
          // 공지글 로드 실패는 무시 (일반 게시글은 계속 표시)
          state = state.copyWith(error: failure.message);
        },
            (notices) {
          state = state.copyWith(notices: notices);
        },
      );
    } catch (e) {
      // 공지글 로드 실패는 무시 (일반 게시글은 계속 표시)
    }
  }

  @override
  void dispose() {
    _postsSubscription?.cancel();
    super.dispose();
  }
}
