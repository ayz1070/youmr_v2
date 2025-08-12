import 'package:cloud_firestore/cloud_firestore.dart';
import '../dtos/post_dto.dart';

abstract class PostDataSource {
  /// 게시글 상세 정보 조회
  /// [postId]: 게시글 ID
  /// 반환: 게시글 DTO 또는 null
  Future<PostDto?> fetchPostById(String postId);

  /// 게시글 목록 불러오기 (일회성)
  /// [category]: 카테고리(전체/null이면 전체)
  /// [startAfter]: 페이징용 마지막 문서
  /// [limit]: 한 번에 불러올 개수(기본 20)
  /// 반환: 게시글 DTO 리스트
  Future<List<PostDto>> fetchPosts({
    String? category,
    DocumentSnapshot? startAfter,
    int limit = 20,
  });

  /// 게시글 목록 실시간 스트림 (좋아요 등 실시간 업데이트용)
  /// [category]: 카테고리(전체/null이면 전체)
  /// [limit]: 한 번에 불러올 개수(기본 20)
  /// 반환: 게시글 DTO 스트림
  Stream<List<PostDto>> fetchPostsStream({
    String? category,
    int limit = 20,
  });

  /// 공지글 목록 조회
  /// [limit]: 조회할 공지글 개수
  /// 반환: 공지글 DTO 리스트
  Future<List<PostDto>> fetchNotices({
    int limit = 3,
  });

  /// 최신 공지글 스트림 조회
  /// [limit]: 조회할 공지글 개수
  /// 반환: 최신 공지글 DTO 스트림
  Stream<List<PostDto>> fetchLatestNoticeStream({
    int limit = 1,
  });

  /// 게시글 삭제
  /// [postId]: 삭제할 게시글 ID
  Future<void> deletePost(String postId);

  /// 게시글 공지 지정/해제
  /// [postId]: 게시글 ID
  /// [isNotice]: 공지 여부
  Future<void> toggleNotice(String postId, bool isNotice);

  /// 게시글 생성
  /// [postData]: 생성할 게시글 데이터
  /// 반환: 생성된 게시글 ID
  Future<String> createPost(Map<String, dynamic> postData);

  /// 게시글의 좋아요 정보 조회
  /// [postId]: 게시글 ID
  /// 반환: 좋아요 정보 (likes 배열, likesCount)
  Future<Map<String, dynamic>> fetchLikeInfo(String postId);

  /// 좋아요 토글 처리 (트랜잭션 사용)
  /// [postId]: 게시글 ID
  /// [userId]: 사용자 ID
  /// [isLiked]: 현재 좋아요 상태
  /// 반환: 성공 여부
  Future<bool> toggleLike(String postId, String userId, bool isLiked);

  /// 게시글의 좋아요 상태 확인
  /// [postId]: 게시글 ID
  /// [userId]: 사용자 ID
  /// 반환: 좋아요 여부
  Future<bool> checkLikeStatus(String postId, String userId);
}
