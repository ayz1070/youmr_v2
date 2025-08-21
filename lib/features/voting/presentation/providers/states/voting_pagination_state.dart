import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/vote.dart';

part 'voting_pagination_state.freezed.dart';

/// 페이징된 투표 목록 상태
@freezed
class VotingPaginationState with _$VotingPaginationState {
  const factory VotingPaginationState({
    @Default([]) List<Vote> votes,
    @Default(false) bool isLoading,
    @Default(true) bool hasMore,
    String? error,
    String? lastDocumentId,
    @Default([]) List<String> selectedVoteIds,
    @Default(false) bool hasInitialized, // 초기화 완료 여부를 추적하는 플래그
  }) = _VotingPaginationState;
}
