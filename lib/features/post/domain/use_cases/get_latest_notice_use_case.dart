import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_failure.dart';
import '../entities/post.dart';
import '../repositories/post_repository.dart';

/// 최신 공지글 조회 UseCase
/// - 최신 공지글을 스트림으로 조회하는 비즈니스 로직
class GetLatestNoticeUseCase {
  /// 게시글 저장소
  final PostRepository _repository;

  /// GetLatestNoticeUseCase 생성자
  /// [repository]: 게시글 저장소 (DI)
  const GetLatestNoticeUseCase({required PostRepository repository})
      : _repository = repository;

  /// 최신 공지글 조회 실행
  /// [limit]: 조회할 공지글 개수
  /// 반환: 성공 시 [Post], 실패 시 [AppFailure]
  Stream<Either<AppFailure, Post?>> call({int limit = 1}) {
    try {
      return _repository.getLatestNoticeStream(limit: limit);
    } catch (e) {
      return Stream.value(Left(AppFailure.serverError('최신 공지글 조회 중 오류가 발생했습니다: $e')));
    }
  }
}
