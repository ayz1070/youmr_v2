import 'package:youmr_v2/features/post/domain/entities/comment.dart';
import 'package:youmr_v2/features/post/domain/repositories/comment_repository.dart';

/// 댓글 목록 조회 Use Case
class GetCommentsUseCase {
  final CommentRepository _repository;

  const GetCommentsUseCase(this._repository);

  /// 게시글의 댓글 목록 스트림을 반환합니다.
  /// 
  /// [postId] 게시글 ID
  /// Returns: 댓글 목록 스트림
  Stream<List<Comment>> call(String postId) {
    return _repository.getCommentsStream(postId);
  }
} 