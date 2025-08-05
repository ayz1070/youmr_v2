import 'package:dartz/dartz.dart';
import 'package:youmr_v2/core/errors/app_failure.dart';
import 'package:youmr_v2/features/post/domain/repositories/comment_repository.dart';

/// 댓글 삭제 Use Case
class DeleteCommentUseCase {
  final CommentRepository _repository;

  const DeleteCommentUseCase(this._repository);

  /// 댓글을 삭제합니다.
  /// 
  /// [commentId] 삭제할 댓글 ID
  /// Returns: 성공 시 void, 실패 시 AppFailure
  Future<Either<AppFailure, void>> call(String commentId) async {
    return await _repository.deleteComment(commentId);
  }
} 