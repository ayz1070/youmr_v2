
import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_failure.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../data_sources/post_firestore_data_source.dart';
import '../dtos/post_dto.dart';
import '../dtos/create_post_dto.dart';
import 'package:youmr_v2/core/constants/app_logger.dart';

/// 게시글 저장소 구현체
/// - DataSource/DTO만 의존, 도메인 변환/예외 처리 담당
class PostRepositoryImpl implements PostRepository {
  final PostFirestoreDataSource dataSource;

  /// [dataSource]: 게시글 데이터 소스(DI)
  PostRepositoryImpl({required this.dataSource});

  /// 게시글 목록 조회 (일회성)
  /// 반환: 성공 시 [Post] 리스트, 실패 시 [AppFailure]
  @override
  Future<Either<AppFailure, List<Post>>> getPosts() async {
    try {
      final postDtos = await dataSource.fetchPosts();
      AppLogger.i("게시글 목록 조회 - DTO 개수: ${postDtos.length}");
      
      final posts = postDtos.map((dto) => dto.toDomain()).toList();
      AppLogger.i("최종 변환된 게시글 개수: ${posts.length}");
      return Right(posts);
    } catch (e, stackTrace) {
      AppLogger.e("게시글 목록 조회 실패: $e");
      AppLogger.e("스택 트레이스: $stackTrace");
      return Left(AppFailure.serverError('게시글 목록 조회 실패: $e'));
    }
  }

  /// 게시글 목록 스트림 조회 (실시간 업데이트용)
  /// [category]: 카테고리 필터
  /// [limit]: 한 번에 불러올 개수
  /// 반환: 성공 시 [Post] 리스트, 실패 시 [AppFailure]
  @override
  Stream<Either<AppFailure, List<Post>>> getPostsStream({
    String? category, 
    int limit = 20
  }) {
    try {
      return dataSource.fetchPostsStream(category: category, limit: limit)
          .map((postDtos) {
            AppLogger.i("게시글 스트림 - DTO 개수: ${postDtos.length}");
            
            // 공지글 제외
            final filteredDtos = postDtos.where((dto) => !dto.isNotice).toList();
            AppLogger.i("공지글 제외 후 DTO 개수: ${filteredDtos.length}");
            
            final posts = filteredDtos.map((dto) => dto.toDomain()).toList();
            AppLogger.i("스트림 최종 변환된 게시글 개수: ${posts.length}");
            return Right<AppFailure, List<Post>>(posts);
          }).handleError((error) {
            AppLogger.e("게시글 스트림 에러: $error");
            return Left<AppFailure, List<Post>>(AppFailure.serverError('게시글 스트림 조회 실패: $error'));
          });
    } catch (e) {
      return Stream.value(Left<AppFailure, List<Post>>(AppFailure.serverError('게시글 스트림 설정 실패: $e')));
    }
  }

  /// 공지글 목록 조회
  /// [limit]: 조회할 공지글 개수
  /// 반환: 성공 시 [Post] 리스트, 실패 시 [AppFailure]
  @override
  Future<Either<AppFailure, List<Post>>> getNotices({int limit = 3}) async {
    try {
      final noticeDtos = await dataSource.fetchNotices(limit: limit);
      AppLogger.i("공지글 목록 조회 - DTO 개수: ${noticeDtos.length}");
      
      final notices = noticeDtos.map((dto) => dto.toDomain()).toList();
      AppLogger.i("최종 변환된 공지글 개수: ${notices.length}");
      return Right(notices);
    } catch (e, stackTrace) {
      AppLogger.e("공지글 목록 조회 실패: $e");
      AppLogger.e("스택 트레이스: $stackTrace");
      return Left(AppFailure.serverError('공지글 목록 조회 실패: $e'));
    }
  }

  /// 최신 공지글 스트림 조회
  /// [limit]: 조회할 공지글 개수
  /// 반환: 성공 시 [Post], 실패 시 [AppFailure]
  @override
  Stream<Either<AppFailure, Post?>> getLatestNoticeStream({int limit = 1}) {
    try {
      return dataSource.fetchLatestNoticeStream(limit: limit)
          .map((noticeDtos) {
            AppLogger.i("최신 공지글 스트림 - DTO 개수: ${noticeDtos.length}");
            
            if (noticeDtos.isEmpty) {
              AppLogger.i("최신 공지글 없음");
              return Right<AppFailure, Post?>(null);
            }
            
            final notice = noticeDtos.first.toDomain();
            AppLogger.i("최신 공지글 도메인 변환 성공: ${notice.runtimeType}");
            return Right<AppFailure, Post?>(notice);
          }).handleError((error) {
            AppLogger.e("최신 공지글 스트림 에러: $error");
            return Left<AppFailure, Post?>(AppFailure.serverError('최신 공지글 스트림 조회 실패: $error'));
          });
    } catch (e) {
      return Stream.value(Left(AppFailure.serverError('최신 공지글 스트림 설정 실패: $e')));
    }
  }

  /// 게시글 상세 정보 조회
  /// [postId]: 게시글 ID
  /// 반환: 성공 시 [Post], 실패 시 [AppFailure]
  @override
  Future<Either<AppFailure, Post>> fetchPostById(String postId) async {
    try {
      final postDto = await dataSource.fetchPostById(postId);
      if (postDto == null) {
        return Left(AppFailure.notFound('게시글을 찾을 수 없습니다: $postId'));
      }
      
      final post = postDto.toDomain();
      return Right(post);
    } catch (e) {
      AppLogger.e("게시글 상세 조회 실패: $e");
      return Left(AppFailure.serverError('게시글 상세 조회 실패: $e'));
    }
  }

  @override
  Stream<Post?> getPostStream(String postId) {
    try {
      return dataSource.getPostStream(postId).map((postDto) {
        if (postDto != null) {
          return postDto.toDomain();
        }
        return null;
      });
    } catch (e) {
      AppLogger.e("게시글 실시간 스트림 조회 실패: $e");
      // 에러 발생 시 빈 스트림 반환
      return Stream.value(null);
    }
  }

  /// 게시글 삭제
  /// [postId]: 삭제할 게시글 ID
  /// 반환: 성공 시 [void], 실패 시 [AppFailure]
  @override
  Future<Either<AppFailure, void>> deletePost(String postId) async {
    try {
      await dataSource.deletePost(postId);
      return const Right(null);
    } catch (e) {
      return Left(AppFailure.serverError('게시글 삭제 실패: $e'));
    }
  }

  /// 게시글 공지 지정/해제
  /// [postId]: 게시글 ID
  /// [isNotice]: 공지 여부
  /// 반환: 성공 시 [void], 실패 시 [AppFailure]
  @override
  Future<Either<AppFailure, void>> toggleNotice(String postId, bool isNotice) async {
    try {
      await dataSource.toggleNotice(postId, isNotice);
      return const Right(null);
    } catch (e) {
      return Left(AppFailure.serverError('게시글 공지 설정 실패: $e'));
    }
  }

  /// 게시글 생성
  /// [post]: 생성할 게시글 엔티티
  /// 반환: 성공 시 생성된 [Post], 실패 시 [AppFailure]
  @override
  Future<Either<AppFailure, Post>> createPost(Post post) async {
    try {
      // Post 엔티티를 CreatePostDto로 변환
      final createPostDto = CreatePostDto(
        authorId: post.authorId,
        authorNickname: post.authorNickname, // authorNickname 사용
        authorProfileUrl: post.authorProfileUrl, // Post 엔티티의 authorProfileUrl 사용
        title: post.title,
        content: post.content,
        category: post.category,
        createdAt: post.createdAt,
        updatedAt: post.updatedAt,
        imageUrls: post.imageUrls,
        backgroundImage: post.backgroundImage,
        isNotice: post.isNotice,
        youtubeUrl: post.youtubeUrl,
      );

      // CreatePostDto를 Map으로 변환하여 DataSource에 전달
      final postData = createPostDto.toMap();
      final postId = await dataSource.createPost(postData);
      
      // 생성된 게시글을 반환 (ID 업데이트)
      final createdPost = post.copyWith(id: postId);
      return Right(createdPost);
    } catch (e) {
      return Left(AppFailure.serverError('게시글 생성 실패: $e'));
    }
  }

  /// 게시글 수정
  /// [postId]: 수정할 게시글 ID
  /// [title]: 새로운 제목
  /// [content]: 새로운 내용
  /// [category]: 새로운 카테고리
  /// 반환: 성공 시 수정된 [Post], 실패 시 [AppFailure]
  @override
  Future<Either<AppFailure, Post>> updatePost({
    required String postId,
    required String title,
    required String content,
    required String category,
  }) async {
    try {
      // 기존 게시글 조회
      final existingPostResult = await fetchPostById(postId);
      if (existingPostResult.isLeft()) {
        return existingPostResult;
      }

      final existingPost = existingPostResult.getOrElse(() => throw Exception('게시글을 찾을 수 없습니다'));
      
      // 수정된 게시글 생성
      final updatedPost = existingPost.copyWith(
        title: title,
        content: content,
        category: category,
        updatedAt: DateTime.now(),
      );

      // TODO: DataSource에 updatePost 메서드 구현 필요
      // await dataSource.updatePost(postId, updatedPost);
      
      return Right(updatedPost);
    } catch (e) {
      return Left(AppFailure.serverError('게시글 수정 실패: $e'));
    }
  }

  /// 게시글의 좋아요 정보 조회
  /// [postId]: 게시글 ID
  /// 반환: 성공 시 좋아요 정보, 실패 시 [AppFailure]
  @override
  Future<Either<AppFailure, Map<String, dynamic>>> fetchLikeInfo(String postId) async {
    try {
      final likeInfo = await dataSource.fetchLikeInfo(postId);
      return Right(likeInfo);
    } catch (e) {
      return Left(AppFailure.serverError('좋아요 정보 조회 실패: $e'));
    }
  }

  /// 좋아요 토글 처리
  /// [postId]: 게시글 ID
  /// [userId]: 사용자 ID
  /// [isLiked]: 현재 좋아요 상태
  /// 반환: 성공 시 [bool] (새로운 좋아요 상태), 실패 시 [AppFailure]
  @override
  Future<Either<AppFailure, bool>> toggleLike(String postId, String userId, bool isLiked) async {
    try {
      final result = await dataSource.toggleLike(postId, userId, isLiked);
      return Right(result);
    } catch (e) {
      return Left(AppFailure.serverError('좋아요 토글 실패: $e'));
    }
  }

  /// 게시글의 좋아요 상태 확인
  /// [postId]: 게시글 ID
  /// [userId]: 사용자 ID
  /// 반환: 성공 시 [bool] (좋아요 여부), 실패 시 [AppFailure]
  @override
  Future<Either<AppFailure, bool>> checkLikeStatus(String postId, String userId) async {
    try {
      final result = await dataSource.checkLikeStatus(postId, userId);
      return Right(result);
    } catch (e) {
      return Left(AppFailure.serverError('좋아요 상태 확인 실패: $e'));
    }
  }

  /// 카테고리별 게시글 개수 조회
  /// 반환: 성공 시 카테고리별 개수 맵, 실패 시 [AppFailure]
  @override
  Future<Either<AppFailure, Map<String, int>>> getPostCountByCategory() async {
    try {
      // TODO: DataSource에 getPostCountByCategory 메서드 구현 필요
      final posts = await dataSource.fetchPosts();
      final categoryCounts = <String, int>{};
      
      for (final post in posts) {
        final category = post.category;
        categoryCounts[category] = (categoryCounts[category] ?? 0) + 1;
      }
      
      return Right(categoryCounts);
    } catch (e) {
      return Left(AppFailure.serverError('카테고리별 게시글 개수 조회 실패: $e'));
    }
  }

  /// 사용자별 게시글 목록 조회
  /// [userId]: 사용자 ID
  /// 반환: 성공 시 [Post] 리스트, 실패 시 [AppFailure]
  @override
  Future<Either<AppFailure, List<Post>>> getPostsByUser(String userId) async {
    try {
      // TODO: DataSource에 getPostsByUser 메서드 구현 필요
      final allPosts = await dataSource.fetchPosts();
      final userPosts = allPosts
          .where((post) => post.authorId == userId)
          .map((dto) => dto.toDomain())
          .toList();
      
      return Right(userPosts);
    } catch (e) {
      return Left(AppFailure.serverError('사용자별 게시글 조회 실패: $e'));
    }
  }

  /// 게시글 검색
  /// [query]: 검색어
  /// [category]: 카테고리 필터 (선택사항)
  /// 반환: 성공 시 [Post] 리스트, 실패 시 [AppFailure]
  @override
  Future<Either<AppFailure, List<Post>>> searchPosts({
    required String query,
    String? category,
  }) async {
    try {
      // TODO: DataSource에 searchPosts 메서드 구현 필요
      final allPosts = await dataSource.fetchPosts();
      final filteredPosts = allPosts
          .where((post) {
            // 카테고리 필터
            if (category != null && post.category != category) {
              return false;
            }
            
            // 검색어 필터 (제목과 내용에서 검색)
            final searchQuery = query.toLowerCase();
            return post.title.toLowerCase().contains(searchQuery) ||
                   post.content.toLowerCase().contains(searchQuery);
          })
          .map((dto) => dto.toDomain())
          .toList();
      
      return Right(filteredPosts);
    } catch (e) {
      return Left(AppFailure.serverError('게시글 검색 실패: $e'));
    }
  }
} 