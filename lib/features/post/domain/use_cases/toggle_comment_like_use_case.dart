import 'package:dartz/dartz.dart';
import 'package:youmr_v2/core/errors/app_failure.dart';
import 'package:youmr_v2/features/post/domain/repositories/comment_repository.dart';

/// 댓글 좋아요 토글 파라미터
class ToggleCommentLikeParams {
  final String commentId;
  final String userId;

  const ToggleCommentLikeParams({
    required this.commentId,
    required this.userId,
  });
}

/// 댓글 좋아요 토글 Use Case
class ToggleCommentLikeUseCase {
  final CommentRepository _repository;

  const ToggleCommentLikeUseCase(this._repository);

  /// 댓글 좋아요를 토글합니다.
  /// 
  /// [params] 댓글 좋아요 토글 파라미터
  /// Returns: 성공 시 void, 실패 시 AppFailure
  Future<Either<AppFailure, void>> call(ToggleCommentLikeParams params) async {
    return await _repository.toggleLike(
      commentId: params.commentId,
      userId: params.userId,
    );
  }
} 