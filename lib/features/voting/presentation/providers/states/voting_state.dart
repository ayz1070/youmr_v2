import 'package:freezed_annotation/freezed_annotation.dart';

part 'voting_state.freezed.dart';

/// 투표 상태 (피크, 선택 등 관리)
@freezed
class VotingState with _$VotingState {
  const factory VotingState({
    @Default([]) List<String> selectedVoteIds,
    @Default(0) int pick,
    String? error,
  }) = _VotingState;
}
