import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:youmr_v2/core/errors/app_failure.dart';
import 'package:youmr_v2/features/post/domain/entities/comment.dart';
import 'package:youmr_v2/features/post/domain/repositories/comment_repository.dart';
import 'package:youmr_v2/features/post/data/repositories/comment_repository_impl.dart';
import 'package:youmr_v2/features/post/data/data_sources/comment_data_source.dart';
import 'package:youmr_v2/features/post/domain/use_cases/get_comments_use_case.dart';
import 'package:youmr_v2/features/post/domain/use_cases/create_comment_use_case.dart';
import 'package:youmr_v2/features/post/domain/use_cases/update_comment_use_case.dart';
import 'package:youmr_v2/features/post/domain/use_cases/delete_comment_use_case.dart';
import 'package:youmr_v2/features/post/domain/use_cases/toggle_comment_like_use_case.dart';
import 'package:youmr_v2/features/post/domain/use_cases/report_comment_use_case.dart';

/// 댓글 상태
class CommentState {
  final List<Comment> comments;
  final bool isLoading;
  final String? error;

  const CommentState({
    this.comments = const [],
    this.isLoading = false,
    this.error,
  });

  CommentState copyWith({
    List<Comment>? comments,
    bool? isLoading,
    String? error,
  }) {
    return CommentState(
      comments: comments ?? this.comments,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// 댓글 Provider
final commentProvider = StateNotifierProvider.family<CommentNotifier, CommentState, String>(
  (ref, postId) => CommentNotifier(
    getComments: ref.read(getCommentsUseCaseProvider),
    createComment: ref.read(createCommentUseCaseProvider),
    updateComment: ref.read(updateCommentUseCaseProvider),
    deleteComment: ref.read(deleteCommentUseCaseProvider),
    toggleLike: ref.read(toggleCommentLikeUseCaseProvider),
    reportComment: ref.read(reportCommentUseCaseProvider),
    postId: postId,
  ),
);

/// 댓글 Notifier
class CommentNotifier extends StateNotifier<CommentState> {
  final GetCommentsUseCase _getComments;
  final CreateCommentUseCase _createComment;
  final UpdateCommentUseCase _updateComment;
  final DeleteCommentUseCase _deleteComment;
  final ToggleCommentLikeUseCase _toggleLike;
  final ReportCommentUseCase _reportComment;
  final String postId;

  CommentNotifier({
    required GetCommentsUseCase getComments,
    required CreateCommentUseCase createComment,
    required UpdateCommentUseCase updateComment,
    required DeleteCommentUseCase deleteComment,
    required ToggleCommentLikeUseCase toggleLike,
    required ReportCommentUseCase reportComment,
    required this.postId,
  })  : _getComments = getComments,
        _createComment = createComment,
        _updateComment = updateComment,
        _deleteComment = deleteComment,
        _toggleLike = toggleLike,
        _reportComment = reportComment,
        super(const CommentState()) {
    _loadComments();
  }

  /// 댓글 목록 로드
  void _loadComments() {
    _getComments(postId).listen(
      (comments) {
        state = state.copyWith(comments: comments);
      },
      onError: (error) {
        state = state.copyWith(error: error.toString());
      },
    );
  }

  /// 댓글 생성
  Future<Either<AppFailure, void>> createComment({
    required String content,
    required String authorNickname,
    String? authorProfileUrl,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Left(AppFailure.unauthorized);
    }

    state = state.copyWith(isLoading: true);

    final result = await _createComment(CreateCommentParams(
      postId: postId,
      content: content,
      authorId: user.uid,
      authorNickname: authorNickname,
      authorProfileUrl: authorProfileUrl,
    ));

    state = state.copyWith(isLoading: false);

    return result.fold(
      (failure) => Left(failure),
      (_) => const Right(null),
    );
  }

  /// 댓글 수정
  Future<Either<AppFailure, void>> updateComment({
    required String commentId,
    required String content,
  }) async {
    state = state.copyWith(isLoading: true);

    final result = await _updateComment(UpdateCommentParams(
      commentId: commentId,
      content: content,
    ));

    state = state.copyWith(isLoading: false);

    return result;
  }

  /// 댓글 삭제
  Future<Either<AppFailure, void>> deleteComment(String commentId) async {
    state = state.copyWith(isLoading: true);

    final result = await _deleteComment(commentId);

    state = state.copyWith(isLoading: false);

    return result;
  }

  /// 댓글 좋아요 토글
  Future<Either<AppFailure, void>> toggleLike(String commentId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Left(AppFailure.unauthorized);
    }

    final result = await _toggleLike(ToggleCommentLikeParams(
      commentId: commentId,
      userId: user.uid,
    ));

    return result;
  }

  /// 댓글 신고
  Future<Either<AppFailure, void>> reportComment({
    required String commentId,
    required String reason,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Left(AppFailure.unauthorized);
    }

    final result = await _reportComment(ReportCommentParams(
      commentId: commentId,
      reporterId: user.uid,
      reason: reason,
    ));

    return result;
  }
}

// Use Case Providers
final getCommentsUseCaseProvider = Provider<GetCommentsUseCase>((ref) {
  final repository = ref.read(commentRepositoryProvider);
  return GetCommentsUseCase(repository);
});

final createCommentUseCaseProvider = Provider<CreateCommentUseCase>((ref) {
  final repository = ref.read(commentRepositoryProvider);
  return CreateCommentUseCase(repository);
});

final updateCommentUseCaseProvider = Provider<UpdateCommentUseCase>((ref) {
  final repository = ref.read(commentRepositoryProvider);
  return UpdateCommentUseCase(repository);
});

final deleteCommentUseCaseProvider = Provider<DeleteCommentUseCase>((ref) {
  final repository = ref.read(commentRepositoryProvider);
  return DeleteCommentUseCase(repository);
});

final toggleCommentLikeUseCaseProvider = Provider<ToggleCommentLikeUseCase>((ref) {
  final repository = ref.read(commentRepositoryProvider);
  return ToggleCommentLikeUseCase(repository);
});

final reportCommentUseCaseProvider = Provider<ReportCommentUseCase>((ref) {
  final repository = ref.read(commentRepositoryProvider);
  return ReportCommentUseCase(repository);
});

// Repository Provider
final commentRepositoryProvider = Provider<CommentRepository>((ref) {
  final dataSource = CommentFirestoreDataSource();
  return CommentRepositoryImpl(dataSource);
}); 