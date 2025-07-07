import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_entity.freezed.dart';
part 'post_entity.g.dart';

/// 게시글 도메인 엔티티
@freezed
class PostEntity with _$PostEntity {
  /// [id] : 게시글 고유 ID
  /// [title] : 제목
  /// [content] : 내용
  /// [authorId] : 작성자 ID
  /// [authorNickname] : 작성자 닉네임
  /// [authorProfileUrl] : 작성자 프로필 이미지
  /// [category] : 카테고리
  /// [youtubeUrl] : 유튜브 링크
  /// [isNotice] : 공지글 여부
  /// [likes] : 좋아요 유저 ID 리스트
  /// [likesCount] : 좋아요 수
  /// [createdAt] : 생성일
  /// [updatedAt] : 수정일
  const factory PostEntity({
    required String id,
    required String title,
    required String content,
    required String authorId,
    required String authorNickname,
    required String authorProfileUrl,
    required String category,
    String? youtubeUrl,
    bool? isNotice,
    List<String>? likes,
    int? likesCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _PostEntity;

  factory PostEntity.fromJson(Map<String, dynamic> json) => _$PostEntityFromJson(json);
} 