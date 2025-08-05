import 'package:dartz/dartz.dart';
import 'package:youmr_v2/core/errors/app_failure.dart';
import 'package:youmr_v2/features/post/domain/repositories/comment_repository.dart';

/// 댓글 수정 파라미터
class UpdateCommentParams {
  final String commentId;
  final String content;

  const UpdateCommentParams({
    required this.commentId,
    required this.content,
  });
}

/// 댓글 수정 Use Case
class UpdateCommentUseCase {
  final CommentRepository _repository;

  const UpdateCommentUseCase(this._repository);

  /// 댓글을 수정합니다.
  /// 
  /// [params] 댓글 수정 파라미터
  /// Returns: 성공 시 void, 실패 시 AppFailure
  Future<Either<AppFailure, void>> call(UpdateCommentParams params) async {
    return await _repository.updateComment(
      commentId: params.commentId,
      content: params.content,
    );
  }
} 