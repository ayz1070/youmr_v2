import 'package:dartz/dartz.dart';
import 'package:youmr_v2/core/errors/app_failure.dart';
import '../entities/comment.dart';

/// 댓글 Repository 인터페이스
abstract class CommentRepository {
  /// 게시글의 댓글 목록 스트림 조회
  Stream<List<Comment>> getCommentsStream(String postId);
  
  /// 댓글 생성
  Future<Either<AppFailure, String>> createComment({
    required String postId,
    required String content,
    required String authorId,
    required String authorNickname,
    String? authorProfileUrl,
  });
  
  /// 댓글 수정
  Future<Either<AppFailure, void>> updateComment({
    required String commentId,
    required String content,
  });
  
  /// 댓글 삭제
  Future<Either<AppFailure, void>> deleteComment(String commentId);
  
  /// 댓글 좋아요/취소
  Future<Either<AppFailure, void>> toggleLike({
    required String commentId,
    required String userId,
  });
  
  /// 댓글 신고
  Future<Either<AppFailure, void>> reportComment({
    required String commentId,
    required String reporterId,
    required String reason,
  });
} 