import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

/// 게시글 도메인 엔티티
/// - 비즈니스 로직에서 사용하는 게시글의 핵심 속성을 정의
@freezed
class Post with _$Post {
  /// 게시글 도메인 엔티티 생성자
  /// [id] 게시글 고유 ID
  /// [authorId] 작성자 ID
  /// [authorName] 작성자 이름
  /// [title] 제목
  /// [content] 내용
  /// [category] 카테고리
  /// [createdAt] 생성일(ISO8601)
  /// [updatedAt] 수정일(ISO8601)
  /// [likeCount] 좋아요 수
  /// [commentCount] 댓글 수
  /// [imageUrls] 이미지 URL 리스트
  const factory Post({
    required String id,
    required String authorId,
    required String authorName,
    required String title,
    required String content,
    required String category,
    required String createdAt,
    required String updatedAt,
    @Default(0) int likeCount,
    @Default(0) int commentCount,
    @Default([]) List<String> imageUrls,
  }) = _Post;

  /// JSON → Post 변환
  /// [json]: JSON 맵
  /// 반환: [Post] 인스턴스
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
} 