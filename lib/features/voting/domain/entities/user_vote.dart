import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_vote.freezed.dart';
part 'user_vote.g.dart';

/// 사용자 투표 기록 도메인 모델
@freezed
class UserVote with _$UserVote {
  const factory UserVote({
    required String userId,
    required String voteId,
    required DateTime votedAt,
  }) = _UserVote;

  factory UserVote.fromJson(Map<String, dynamic> json) => _$UserVoteFromJson(json);
} 