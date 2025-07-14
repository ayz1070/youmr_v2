import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/post.dart';

part 'post_dto.freezed.dart';
part 'post_dto.g.dart';

/// 게시글 DTO
/// 외부 데이터(JSON) ↔ 내부 엔티티(Post) 변환을 담당합니다.
@freezed
class PostDto with _$PostDto {
  /// 게시글 DTO 생성자
  const factory PostDto({
    /// 게시글 고유 ID
    required String id,
    /// 작성자 ID
    required String authorId,
    /// 작성자 이름
    required String authorName,
    /// 제목
    required String title,
    /// 내용
    required String content,
    /// 카테고리
    required String category,
    /// 생성일(ISO8601)
    required String createdAt,
    /// 수정일(ISO8601)
    required String updatedAt,
    /// 좋아요 수
    @Default(0) int likeCount,
    /// 댓글 수
    @Default(0) int commentCount,
    /// 이미지 URL 리스트
    @Default([]) List<String> imageUrls,
  }) = _PostDto;

  /// JSON → PostDto 변환
  factory PostDto.fromJson(Map<String, dynamic> json) => _$PostDtoFromJson(json);
}

/// PostDto <-> Post 변환 확장
extension PostDtoDomainMapper on PostDto {
  /// DTO → 도메인 엔티티
  Post toDomain() => Post(
        id: id,
        authorId: authorId,
        authorName: authorName,
        title: title,
        content: content,
        category: category,
        createdAt: createdAt,
        updatedAt: updatedAt,
        likeCount: likeCount,
        commentCount: commentCount,
        imageUrls: imageUrls,
      );
}

extension PostDtoFromDomain on Post {
  /// 도메인 엔티티 → DTO
  PostDto toDto() => PostDto(
        id: id,
        authorId: authorId,
        authorName: authorName,
        title: title,
        content: content,
        category: category,
        createdAt: createdAt,
        updatedAt: updatedAt,
        likeCount: likeCount,
        commentCount: commentCount,
        imageUrls: imageUrls,
      );
} 