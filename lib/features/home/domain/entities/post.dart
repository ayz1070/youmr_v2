import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

/// 게시글 도메인 엔티티
/// 비즈니스 로직에서 사용하는 게시글의 핵심 속성을 정의합니다.
@freezed
class Post with _$Post {
  /// 게시글 도메인 엔티티 생성자
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
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
} 