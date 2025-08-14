import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_failure.dart';
import '../entities/post.dart';
import '../repositories/post_repository.dart';

/// 게시글 스트림 조회 UseCase
/// - 게시글 목록을 실시간 스트림으로 조회하는 비즈니스 로직
class GetPostsStreamUseCase {
  /// 게시글 저장소
  final PostRepository _repository;

  /// GetPostsStreamUseCase 생성자
  /// [repository]: 게시글 저장소 (DI)
  const GetPostsStreamUseCase({required PostRepository repository})
      : _repository = repository;

  /// 게시글 스트림 조회 실행
  /// [category]: 카테고리 필터
  /// [limit]: 한 번에 불러올 개수
  /// 반환: 성공 시 [Post] 리스트, 실패 시 [AppFailure]
  Stream<Either<AppFailure, List<Post>>> call({
    String? category,
    int limit = 20,
  }) {
    try {
      return _repository.getPostsStream(category: category, limit: limit);
    } catch (e) {
      return Stream.value(Left(AppFailure.serverError('게시글 스트림 조회 중 오류가 발생했습니다: $e')));
    }
  }
}
