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
    return _dataSource.fetchCommentsStream(postId).map((dtos) =>
        dtos.map((dto) => _mapDtoToEntity(dto)).toList());
  }

  @override
  Future<Either<AppFailure, String>> createComment({
    required String postId,
    required String content,
    required String authorId,
    required String authorNickname,
    String? authorProfileUrl,
  }) async {
    return _handleAsyncOperation(() async {
      final commentDto = CommentDto(
        id: '', // Firestore에서 자동 생성
        postId: postId,
        content: content,
        authorId: authorId,
        authorNickname: authorNickname,
        authorProfileUrl: authorProfileUrl,
        createdAt: DateTime.now(),
      );

      return await _dataSource.createComment(commentDto);
    });
  }

  @override
  Future<Either<AppFailure, void>> updateComment({
    required String commentId,
    required String content,
  }) async {
    return _handleAsyncOperation(() async {
      await _dataSource.updateComment(commentId, content);
    });
  }

  @override
  Future<Either<AppFailure, void>> deleteComment(String commentId) async {
    return _handleAsyncOperation(() async {
      await _dataSource.deleteComment(commentId);
    });
  }

  @override
  Future<Either<AppFailure, void>> toggleLike({
    required String commentId,
    required String userId,
  }) async {
    return _handleAsyncOperation(() async {
      await _dataSource.toggleLike(commentId, userId);
    });
  }

  @override
  Future<Either<AppFailure, void>> reportComment({
    required String commentId,
    required String reporterId,
    required String reason,
  }) async {
    return _handleAsyncOperation(() async {
      await _dataSource.reportComment(commentId, reporterId, reason);
    });
  }

  /// DTO를 도메인 엔티티로 변환하는 헬퍼 메서드
  Comment _mapDtoToEntity(CommentDto dto) {
    return Comment(
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
    );
  }

  /// 비동기 작업의 에러 처리를 통합하는 헬퍼 메서드
  Future<Either<AppFailure, T>> _handleAsyncOperation<T>(Future<T> Function() operation) async {
    try {
      final result = await operation();
      return Right(result);
    } catch (e) {
      return Left(AppFailure.serverError(e.toString()));
    }
  }
} 