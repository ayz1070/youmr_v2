import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_dto.freezed.dart';
part 'post_dto.g.dart';

/// 게시글 DTO
/// 외부 데이터(JSON) ↔ 내부 엔티티(Post) 변환을 담당합니다.
@freezed
class PostDto with _$PostDto {
  /// 게시글 DTO 생성자
  const factory PostDto({
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
  }) = _PostDto;

  /// JSON → PostDto 변환
  factory PostDto.fromJson(Map<String, dynamic> json) => _$PostDtoFromJson(json);
} 