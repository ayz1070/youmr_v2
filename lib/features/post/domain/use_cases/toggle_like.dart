import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_failure.dart';
import '../repositories/post_repository.dart';

/// 게시글 좋아요 토글 UseCase
/// - 게시글의 좋아요 상태를 토글하는 비즈니스 로직
class ToggleLike {
  /// 게시글 저장소
  final PostRepository _repository;

  /// ToggleLike 생성자
  /// [repository]: 게시글 저장소 (DI)
  const ToggleLike({required PostRepository repository})
      : _repository = repository;

  /// 좋아요 토글 실행
  /// [postId]: 게시글 ID
  /// [userId]: 사용자 ID
  /// [isLiked]: 현재 좋아요 상태
  /// 반환: 성공 시 [bool] (새로운 좋아요 상태), 실패 시 [AppFailure]
  Future<Either<AppFailure, bool>> call({
    required String postId,
    required String userId,
    required bool isLiked,
  }) async {
    try {
      final result = await _repository.toggleLike(postId, userId, isLiked);
      return result.fold(
        (failure) => Left(failure),
        (newLikeStatus) => Right(newLikeStatus),
      );
    } catch (e) {
      return Left(AppFailure.serverError('좋아요 토글 중 오류가 발생했습니다: $e'));
    }
  }
}
