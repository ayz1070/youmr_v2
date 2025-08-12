import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_failure.dart';
import '../repositories/post_repository.dart';

/// 게시글 좋아요 정보 조회 UseCase
/// - 게시글의 좋아요 정보를 조회하는 비즈니스 로직
class FetchLikeInfo {
  /// 게시글 저장소
  final PostRepository _repository;

  /// FetchLikeInfo 생성자
  /// [repository]: 게시글 저장소 (DI)
  const FetchLikeInfo({required PostRepository repository})
      : _repository = repository;

  /// 좋아요 정보 조회 실행
  /// [postId]: 게시글 ID
  /// 반환: 성공 시 좋아요 정보, 실패 시 [AppFailure]
  Future<Either<AppFailure, Map<String, dynamic>>> call(String postId) async {
    try {
      final result = await _repository.fetchLikeInfo(postId);
      return result.fold(
        (failure) => Left(failure),
        (likeInfo) => Right(likeInfo),
      );
    } catch (e) {
      return Left(AppFailure.serverError('좋아요 정보 조회 중 오류가 발생했습니다: $e'));
    }
  }
}
