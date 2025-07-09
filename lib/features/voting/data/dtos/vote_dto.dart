import 'package:freezed_annotation/freezed_annotation.dart';

part 'vote_dto.freezed.dart';
part 'vote_dto.g.dart';

/// Firestore 투표 곡 문서 매핑용 DTO
@freezed
class VoteDto with _$VoteDto {
  const factory VoteDto({
    required String id,
    required String title,
    required String artist,
    String? youtubeUrl,
    required int voteCount,
    required DateTime createdAt,
    required String createdBy,
  }) = _VoteDto;

  factory VoteDto.fromJson(Map<String, dynamic> json) => _$VoteDtoFromJson(json);
} 