import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_vote_dto.freezed.dart';
part 'user_vote_dto.g.dart';

/// Firestore 사용자 투표 기록 문서 매핑용 DTO
@freezed
class UserVoteDto with _$UserVoteDto {
  const factory UserVoteDto({
    required String userId,
    required String voteId,
    required DateTime votedAt,
  }) = _UserVoteDto;

  factory UserVoteDto.fromJson(Map<String, dynamic> json) => _$UserVoteDtoFromJson(json);
} 