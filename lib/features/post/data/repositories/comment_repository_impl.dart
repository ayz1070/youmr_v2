import 'package:dartz/dartz.dart';
import 'package:youmr_v2/core/errors/app_failure.dart';
import 'package:youmr_v2/features/post/domain/entities/comment.dart';
import 'package:youmr_v2/features/post/domain/repositories/comment_repository.dart';
import 'package:youmr_v2/features/post/data/data_sources/comment_data_source.dart';
import 'package:youmr_v2/features/post/data/dtos/comment_dto.dart';

/// 댓글 Repository 구현체
class CommentRepositoryImpl implements CommentRepository {
  final CommentDataSource _dataSource;

  const CommentRepositoryImpl(this._dataSource);

  @override
  Stream<List<Comment>> getCommentsStream(String postId) {
    return _dataSource.getCommentsStream(postId).map((dtos) =>
        dtos.map((dto) => Comment(
          id: dto.id,
          postId: dto.postId,
          content: dto.content,
          authorId: dto.authorId,
          authorNickname: dto.authorNickname,
          authorProfileUrl: dto.authorProfileUrl,
          likes: dto.likes,
          likesCount: dto.likesCount,
          createdAt: dto.createdAt,
          serverCreatedAt: dto.serverCreatedAt,
        )).toList());
  }

  @override
  Future<Either<AppFailure, String>> createComment({
    required String postId,
    required String content,
    required String authorId,
    required String authorNickname,
    String? authorProfileUrl,
  }) async {
    try {
      final commentDto = CommentDto(
        id: '', // Firestore에서 자동 생성
        postId: postId,
        content: content,
        authorId: authorId,
        authorNickname: authorNickname,
        authorProfileUrl: authorProfileUrl,
        createdAt: DateTime.now(),
      );

      final commentId = await _dataSource.createComment(commentDto);
      return Right(commentId);
    } catch (e) {
      return Left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> updateComment({
    required String commentId,
    required String content,
  }) async {
    try {
      await _dataSource.updateComment(commentId, content);
      return const Right(null);
    } catch (e) {
      return Left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> deleteComment(String commentId) async {
    try {
      await _dataSource.deleteComment(commentId);
      return const Right(null);
    } catch (e) {
      return Left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> toggleLike({
    required String commentId,
    required String userId,
  }) async {
    try {
      await _dataSource.toggleLike(commentId, userId);
      return const Right(null);
    } catch (e) {
      return Left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> reportComment({
    required String commentId,
    required String reporterId,
    required String reason,
  }) async {
    try {
      await _dataSource.reportComment(commentId, reporterId, reason);
      return const Right(null);
    } catch (e) {
      return Left(AppFailure.serverError(e.toString()));
    }
  }
} 