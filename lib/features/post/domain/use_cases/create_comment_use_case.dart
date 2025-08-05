import 'package:dartz/dartz.dart';
import 'package:youmr_v2/core/errors/app_failure.dart';
import 'package:youmr_v2/features/post/domain/repositories/comment_repository.dart';

/// 댓글 생성 파라미터
class CreateCommentParams {
  final String postId;
  final String content;
  final String authorId;
  final String authorNickname;
  final String? authorProfileUrl;

  const CreateCommentParams({
    required this.postId,
    required this.content,
    required this.authorId,
    required this.authorNickname,
    this.authorProfileUrl,
  });
}

/// 댓글 생성 Use Case
class CreateCommentUseCase {
  final CommentRepository _repository;

  const CreateCommentUseCase(this._repository);

  /// 댓글을 생성합니다.
  /// 
  /// [params] 댓글 생성 파라미터
  /// Returns: 성공 시 댓글 ID, 실패 시 AppFailure
  Future<Either<AppFailure, String>> call(CreateCommentParams params) async {
    return await _repository.createComment(
      postId: params.postId,
      content: params.content,
      authorId: params.authorId,
      authorNickname: params.authorNickname,
      authorProfileUrl: params.authorProfileUrl,
    );
  }
} 