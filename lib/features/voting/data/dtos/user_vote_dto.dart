import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user_vote.dart';

part 'user_vote_dto.freezed.dart';
part 'user_vote_dto.g.dart';

/// Firestore 사용자 투표 기록 문서 매핑용 DTO
@freezed
class UserVoteDto with _$UserVoteDto {
  /// 생성자
  const factory UserVoteDto({
    /// 사용자 ID
    required String userId,
    /// 곡 ID
    required String voteId,
    /// 투표 일시
    required DateTime votedAt,
  }) = _UserVoteDto;

  /// JSON → DTO 변환
  factory UserVoteDto.fromJson(Map<String, dynamic> json) =>
      _$UserVoteDtoFromJson(json);

  /// 도메인 → DTO 변환
  factory UserVoteDto.fromDomain(UserVote userVote) => UserVoteDto(
        userId: userVote.userId,
        voteId: userVote.voteId,
        votedAt: userVote.votedAt,
      );
}

/// UserVoteDto → 도메인 모델 변환 확장
extension UserVoteDtoX on UserVoteDto {
  /// UserVoteDto → UserVote 변환
  UserVote toDomain() => UserVote(
        userId: userId,
        voteId: voteId,
        votedAt: votedAt,
      );
} 