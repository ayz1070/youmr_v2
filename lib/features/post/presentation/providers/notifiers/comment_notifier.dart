import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:youmr_v2/core/errors/app_failure.dart';
import 'package:youmr_v2/features/post/domain/use_cases/get_comments_use_case.dart';
import 'package:youmr_v2/features/post/domain/use_cases/create_comment_use_case.dart';
import 'package:youmr_v2/features/post/domain/use_cases/update_comment_use_case.dart';
import 'package:youmr_v2/features/post/domain/use_cases/delete_comment_use_case.dart';
import 'package:youmr_v2/features/post/domain/use_cases/toggle_comment_like_use_case.dart';
import 'package:youmr_v2/features/post/domain/use_cases/report_comment_use_case.dart';

import '../states/comment_state.dart';

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