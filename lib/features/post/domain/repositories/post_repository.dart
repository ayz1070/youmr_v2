
import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_failure.dart';
import '../entities/post.dart';

/// 게시글 저장소 인터페이스
/// - 데이터 접근을 추상화하여 의존성 역전을 실현
/// - 함수형 에러 처리와 타입 안전성 보장
abstract class PostRepository {
  /// 게시글 목록 조회 (일회성)
  /// 반환: 성공 시 [Post] 리스트, 실패 시 [AppFailure]
  Future<Either<AppFailure, List<Post>>> getPosts();

  /// 게시글 목록 스트림 조회 (실시간 업데이트용)
  /// [category]: 카테고리 필터
  /// [limit]: 한 번에 불러올 개수
  /// 반환: 성공 시 [Post] 리스트, 실패 시 [AppFailure]
  Stream<Either<AppFailure, List<Post>>> getPostsStream({
    String? category, 
    int limit = 20
  });

  /// 공지글 목록 조회
  /// [limit]: 조회할 공지글 개수
  /// 반환: 성공 시 [Post] 리스트, 실패 시 [AppFailure]
  Future<Either<AppFailure, List<Post>>> getNotices({int limit = 3});

  /// 최신 공지글 스트림 조회
  /// [limit]: 조회할 공지글 개수
  /// 반환: 성공 시 [Post], 실패 시 [AppFailure]
  Stream<Either<AppFailure, Post?>> getLatestNoticeStream({int limit = 1});

  /// 게시글 상세 정보 조회
  /// [postId]: 게시글 ID
  /// 반환: 성공 시 [Post], 실패 시 [AppFailure]
  Future<Either<AppFailure, Post>> fetchPostById(String postId);

  /// 게시글 상세 정보 실시간 스트림 조회
  /// [postId]: 게시글 ID
  /// 반환: 실시간 업데이트되는 [Post] 스트림
  Stream<Post?> getPostStream(String postId);

  /// 게시글 삭제
  /// [postId]: 삭제할 게시글 ID
  /// 반환: 성공 시 [void], 실패 시 [AppFailure]
  Future<Either<AppFailure, void>> deletePost(String postId);

  /// 게시글 공지 지정/해제
  /// [postId]: 게시글 ID
  /// [isNotice]: 공지 여부
  /// 반환: 성공 시 [void], 실패 시 [AppFailure]
  Future<Either<AppFailure, void>> toggleNotice(String postId, bool isNotice);

  /// 게시글 생성
  /// [post]: 생성할 게시글 엔티티
  /// 반환: 성공 시 생성된 [Post], 실패 시 [AppFailure]
  Future<Either<AppFailure, Post>> createPost(Post post);

  /// 게시글 수정
  /// [postId]: 수정할 게시글 ID
  /// [title]: 새로운 제목
  /// [content]: 새로운 내용
  /// [category]: 새로운 카테고리
  /// 반환: 성공 시 수정된 [Post], 실패 시 [AppFailure]
  Future<Either<AppFailure, Post>> updatePost({
    required String postId,
    required String title,
    required String content,
    required String category,
  });

  /// 게시글의 좋아요 정보 조회
  /// [postId]: 게시글 ID
  /// 반환: 성공 시 좋아요 정보, 실패 시 [AppFailure]
  Future<Either<AppFailure, Map<String, dynamic>>> fetchLikeInfo(String postId);

  /// 좋아요 토글 처리
  /// [postId]: 게시글 ID
  /// [userId]: 사용자 ID
  /// [isLiked]: 현재 좋아요 상태
  /// 반환: 성공 시 [bool] (새로운 좋아요 상태), 실패 시 [AppFailure]
  Future<Either<AppFailure, bool>> toggleLike(String postId, String userId, bool isLiked);

  /// 게시글의 좋아요 상태 확인
  /// [postId]: 게시글 ID
  /// [userId]: 사용자 ID
  /// 반환: 성공 시 [bool] (좋아요 여부), 실패 시 [AppFailure]
  Future<Either<AppFailure, bool>> checkLikeStatus(String postId, String userId);

  /// 카테고리별 게시글 개수 조회
  /// 반환: 성공 시 카테고리별 개수 맵, 실패 시 [AppFailure]
  Future<Either<AppFailure, Map<String, int>>> getPostCountByCategory();

  /// 사용자별 게시글 목록 조회
  /// [userId]: 사용자 ID
  /// 반환: 성공 시 [Post] 리스트, 실패 시 [AppFailure]
  Future<Either<AppFailure, List<Post>>> getPostsByUser(String userId);

  /// 게시글 검색
  /// [query]: 검색어
  /// [category]: 카테고리 필터 (선택사항)
  /// 반환: 성공 시 [Post] 리스트, 실패 시 [AppFailure]
  Future<Either<AppFailure, List<Post>>> searchPosts({
    required String query,
    String? category,
  });
} 