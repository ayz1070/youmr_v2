import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

/// 게시글 엔티티 (Data 계층)
/// Firestore 등 외부 데이터 소스에서 받아오는 게시글의 원시 데이터 구조를 정의합니다.
@freezed
class Post with _$Post {
  /// 게시글 생성자
  const factory Post({
    /// 게시글 고유 ID
    required String id,

    /// 작성자 UID
    required String authorId,

    /// 작성자 닉네임
    required String authorName,

    /// 게시글 제목
    required String title,

    /// 게시글 본문
    required String content,

    /// 게시글 카테고리
    required String category,

    /// 작성 시각 (Timestamp 또는 ISO8601 문자열)
    required String createdAt,

    /// 마지막 수정 시각 (Timestamp 또는 ISO8601 문자열)
    required String updatedAt,

    /// 좋아요 수
    @Default(0) int likeCount,

    /// 댓글 수
    @Default(0) int commentCount,

    /// 게시글에 첨부된 이미지 URL 목록
    @Default([]) List<String> imageUrls,
  }) = _Post;

  /// JSON → Post 변환
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
} 