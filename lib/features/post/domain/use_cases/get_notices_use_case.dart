import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_failure.dart';
import '../entities/post.dart';
import '../repositories/post_repository.dart';

/// 공지글 목록 조회 UseCase
/// - 공지글 목록을 조회하는 비즈니스 로직
class GetNoticesUseCase {
  /// 게시글 저장소
  final PostRepository _repository;

  /// GetNoticesUseCase 생성자
  /// [repository]: 게시글 저장소 (DI)
  const GetNoticesUseCase({required PostRepository repository})
      : _repository = repository;

  /// 공지글 목록 조회 실행
  /// [limit]: 조회할 공지글 개수
  /// 반환: 성공 시 [Post] 리스트, 실패 시 [AppFailure]
  Future<Either<AppFailure, List<Post>>> call({int limit = 3}) async {
    try {
      final result = await _repository.getNotices(limit: limit);
      return result.fold(
        (failure) => Left(failure),
        (notices) => Right(notices),
      );
    } catch (e) {
      return Left(AppFailure.serverError('공지글 목록 조회 중 오류가 발생했습니다: $e'));
    }
  }
}
