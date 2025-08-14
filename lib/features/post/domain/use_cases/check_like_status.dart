import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_failure.dart';
import '../repositories/post_repository.dart';

/// 게시글 좋아요 상태 확인 UseCase
/// - 게시글에 대한 사용자의 좋아요 상태를 확인하는 비즈니스 로직
class CheckLikeStatus {
  /// 게시글 저장소
  final PostRepository _repository;

  /// CheckLikeStatus 생성자
  /// [repository]: 게시글 저장소 (DI)
  const CheckLikeStatus({required PostRepository repository})
      : _repository = repository;

  /// 좋아요 상태 확인 실행
  /// [postId]: 게시글 ID
  /// [userId]: 사용자 ID
  /// 반환: 성공 시 [bool] (좋아요 여부), 실패 시 [AppFailure]
  Future<Either<AppFailure, bool>> call({
    required String postId,
    required String userId,
  }) async {
    try {
      final result = await _repository.checkLikeStatus(postId, userId);
      return result.fold(
        (failure) => Left(failure),
        (isLiked) => Right(isLiked),
      );
    } catch (e) {
      return Left(AppFailure.serverError('좋아요 상태 확인 중 오류가 발생했습니다: $e'));
    }
  }
}
