import '../dtos/comment_dto.dart';

/// 댓글 데이터 소스 인터페이스
/// - 댓글 CRUD 작업을 추상화
abstract class CommentDataSource {
  /// 댓글 목록 조회 (일회성)
  /// [postId]: 게시글 ID
  /// 반환: 댓글 DTO 리스트
  Future<List<CommentDto>> fetchComments(String postId);

  /// 댓글 스트림 조회
  /// [postId]: 게시글 ID
  /// 반환: 댓글 DTO 스트림
  Stream<List<CommentDto>> fetchCommentsStream(String postId);

  /// 댓글 상세 정보 조회
  /// [commentId]: 댓글 ID
  /// 반환: 댓글 DTO 또는 null
  Future<CommentDto?> fetchCommentById(String commentId);

  /// 댓글 생성
  /// [comment]: 생성할 댓글 DTO
  /// 반환: 생성된 댓글 ID
  Future<String> createComment(CommentDto comment);

  /// 댓글 수정
  /// [commentId]: 수정할 댓글 ID
  /// [content]: 새로운 내용
  Future<void> updateComment(String commentId, String content);

  /// 댓글 삭제
  /// [commentId]: 삭제할 댓글 ID
  Future<void> deleteComment(String commentId);

  /// 댓글 좋아요 토글
  /// [commentId]: 댓글 ID
  /// [userId]: 사용자 ID
  /// 반환: 성공 여부
  Future<bool> toggleLike(String commentId, String userId);

  /// 댓글의 좋아요 상태 확인
  /// [commentId]: 댓글 ID
  /// [userId]: 사용자 ID
  /// 반환: 좋아요 여부
  Future<bool> checkLikeStatus(String commentId, String userId);

  /// 댓글 신고
  /// [commentId]: 댓글 ID
  /// [reporterId]: 신고자 ID
  /// [reason]: 신고 사유
  Future<void> reportComment(String commentId, String reporterId, String reason);
}

