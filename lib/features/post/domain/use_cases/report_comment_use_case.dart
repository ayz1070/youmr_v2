import 'package:dartz/dartz.dart';
import 'package:youmr_v2/core/errors/app_failure.dart';
import 'package:youmr_v2/features/post/domain/repositories/comment_repository.dart';

/// 댓글 신고 파라미터
class ReportCommentParams {
  final String commentId;
  final String reporterId;
  final String reason;

  const ReportCommentParams({
    required this.commentId,
    required this.reporterId,
    required this.reason,
  });
}

/// 댓글 신고 Use Case
class ReportCommentUseCase {
  final CommentRepository _repository;

  const ReportCommentUseCase(this._repository);

  /// 댓글을 신고합니다.
  /// 
  /// [params] 댓글 신고 파라미터
  /// Returns: 성공 시 void, 실패 시 AppFailure
  Future<Either<AppFailure, void>> call(ReportCommentParams params) async {
    return await _repository.reportComment(
      commentId: params.commentId,
      reporterId: params.reporterId,
      reason: params.reason,
    );
  }
} 