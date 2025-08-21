
import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_failure.dart';
import '../entities/post.dart';
import '../repositories/post_repository.dart';

/// 게시글 목록 조회 UseCase
/// - 게시글 목록 조회의 비즈니스 로직을 캡슐화
/// - 단일 책임 원칙 준수 및 에러 처리
class GetPostsUseCase {
  /// 게시글 저장소
  final PostRepository _repository;

  /// GetPostsUseCase 생성자
  /// [repository]: 게시글 저장소 (DI)
  const GetPostsUseCase({required PostRepository repository})
      : _repository = repository;

  /// 게시글 목록 조회 실행
  /// 반환: 성공 시 [Post] 리스트, 실패 시 [AppFailure]
  Future<Either<AppFailure, List<Post>>> call() async {
    try {
      final result = await _repository.getPosts();
      return result.fold(
        (failure) => Left(failure),
        (posts) => Right(posts),
      );
    } catch (e) {
      return Left(AppFailure.serverError('게시글 목록 조회 중 오류가 발생했습니다: $e'));
    }
  }

  /// 카테고리별 게시글 목록 조회 실행
  /// [category]: 카테고리 (선택사항)
  /// 반환: 성공 시 [Post] 리스트, 실패 시 [AppFailure]
  Future<Either<AppFailure, List<Post>>> callWithCategory(String? category) async {
    try {
      if (category == null || category.trim().isEmpty) {
        return call();
      }

      final result = await _repository.getPostsStream(category: category, limit: 20).first;
      
      return result.fold(
        (failure) => Left(failure),
        (posts) => Right(posts),
      );
    } catch (e) {
      return Left(AppFailure.serverError('카테고리별 게시글 조회 중 오류가 발생했습니다: $e'));
    }
  }

  /// 게시글 목록 스트림 조회 실행
  /// [category]: 카테고리 (선택사항)
  /// [limit]: 한 번에 불러올 개수
  /// 반환: 성공 시 [Post] 리스트, 실패 시 [AppFailure]
  Stream<Either<AppFailure, List<Post>>> callStream({
    String? category,
    int limit = 20,
  }) {
    try {
      return _repository.getPostsStream(category: category, limit: limit);
    } catch (e) {
      return Stream.value(Left(AppFailure.serverError(
        '게시글 스트림 조회 중 오류가 발생했습니다: $e'
      )));
    }
  }

  /// 게시글 목록 필터링
  /// [posts]: 원본 게시글 리스트
  /// [filters]: 필터 조건들
  /// 반환: 필터링된 게시글 리스트
  List<Post> filterPosts(List<Post> posts, {
    String? category,
    bool? isNotice,
    bool? hasImages,
    bool? isPopular,
    bool? isActive,
  }) {
    return posts.where((post) {
      // 카테고리 필터
      if (category != null && post.category != category) {
        return false;
      }

      // 공지사항 필터
      if (isNotice != null && post.isNotice != isNotice) {
        return false;
      }

      // 이미지 보유 필터
      if (hasImages != null && post.hasImages != hasImages) {
        return false;
      }

      // 인기 게시글 필터
      if (isPopular != null && post.isPopular != isPopular) {
        return false;
      }

      // 활발한 게시글 필터
      if (isActive != null && post.isActive != isActive) {
        return false;
      }

      return true;
    }).toList();
  }

  /// 게시글 목록 정렬
  /// [posts]: 정렬할 게시글 리스트
  /// [sortBy]: 정렬 기준
  /// [ascending]: 오름차순 여부
  /// 반환: 정렬된 게시글 리스트
  List<Post> sortPosts(List<Post> posts, {
    PostSortBy sortBy = PostSortBy.createdAt,
    bool ascending = false,
  }) {
    final sortedPosts = List<Post>.from(posts);
    
    switch (sortBy) {
      case PostSortBy.createdAt:
        sortedPosts.sort((a, b) => ascending 
          ? a.createdAt.compareTo(b.createdAt)
          : b.createdAt.compareTo(a.createdAt));
        break;
      case PostSortBy.updatedAt:
        sortedPosts.sort((a, b) => ascending 
          ? a.updatedAt.compareTo(b.updatedAt)
          : b.updatedAt.compareTo(a.updatedAt));
        break;
      case PostSortBy.likeCount:
        sortedPosts.sort((a, b) => ascending 
          ? a.likeCount.compareTo(b.likeCount)
          : b.likeCount.compareTo(a.likeCount));
        break;
      case PostSortBy.commentCount:
        sortedPosts.sort((a, b) => ascending 
          ? a.commentCount.compareTo(b.commentCount)
          : b.commentCount.compareTo(a.commentCount));
        break;
      case PostSortBy.title:
        sortedPosts.sort((a, b) => ascending 
          ? a.title.compareTo(b.title)
          : b.title.compareTo(a.title));
        break;
    }
    
    return sortedPosts;
  }
}

/// 게시글 정렬 기준 열거형
enum PostSortBy {
  /// 생성 시간
  createdAt,
  
  /// 수정 시간
  updatedAt,
  
  /// 좋아요 수
  likeCount,
  
  /// 댓글 수
  commentCount,
  
  /// 제목
  title,
} 