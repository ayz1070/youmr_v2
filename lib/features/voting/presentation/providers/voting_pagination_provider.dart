import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/vote.dart';
import '../../domain/repositories/voting_repository.dart';
import '../../data/repositories/voting_repository_impl.dart';
import '../../data/data_sources/voting_firestore_data_source.dart';
import '../../../../core/errors/voting_failure.dart';
import '../../../../core/constants/app_logger.dart';

/// 페이징된 투표 목록 상태
class VotingPaginationState {
  final List<Vote> votes;
  final bool isLoading;
  final bool hasMore;
  final String? error;
  final String? lastDocumentId;
  final List<String> selectedVoteIds;

  const VotingPaginationState({
    this.votes = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.error,
    this.lastDocumentId,
    this.selectedVoteIds = const [],
  });

  VotingPaginationState copyWith({
    List<Vote>? votes,
    bool? isLoading,
    bool? hasMore,
    String? error,
    String? lastDocumentId,
    List<String>? selectedVoteIds,
  }) {
    return VotingPaginationState(
      votes: votes ?? this.votes,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      error: error ?? this.error,
      lastDocumentId: lastDocumentId ?? this.lastDocumentId,
      selectedVoteIds: selectedVoteIds ?? this.selectedVoteIds,
    );
  }
}

/// 페이징된 투표 목록 Provider
final votingPaginationProvider = NotifierProvider<VotingPaginationProvider, VotingPaginationState>(
  VotingPaginationProvider.new,
);

class VotingPaginationProvider extends Notifier<VotingPaginationState> {
  late final VotingRepository _repository;
  static const int pageSize = 10;

  @override
  VotingPaginationState build() {
    _repository = VotingRepositoryImpl(
      dataSource: VotingFirestoreDataSource(),
    );
    
    // 초기 데이터 로드 (다음 프레임에서 실행)
    Future.microtask(() => _loadInitialData());
    return const VotingPaginationState();
  }

  /// 투표 선택 토글
  void toggleVote(String voteId) {
    final currentSelected = List<String>.from(state.selectedVoteIds);
    if (currentSelected.contains(voteId)) {
      currentSelected.remove(voteId);
    } else {
      currentSelected.add(voteId);
    }
    state = state.copyWith(selectedVoteIds: currentSelected);
  }

  /// 선택된 투표 제출
  Future<VotingFailure?> submitVotes(String userId) async {
    final result = await _repository.submitVotes(
      userId: userId, 
      voteIds: state.selectedVoteIds,
    );
    
    return result.fold(
      (failure) => failure,
      (_) {
        // 성공 시 선택 상태 초기화
        state = state.copyWith(selectedVoteIds: []);
        // 투표 완료 후 목록 새로고침하여 voteCount 업데이트
        Future.microtask(() => _loadInitialData());
        return null;
      },
    );
  }

  /// 일일 피크 획득
  Future<VotingFailure?> getDailyPick(String userId) async {
    final result = await _repository.getDailyPick(userId: userId);
    return result.fold(
      (failure) => failure,
      (_) => null,
    );
  }

  /// 초기 데이터 로드
  Future<void> _loadInitialData() async {
    AppLogger.d('_loadInitialData 시작');
    state = state.copyWith(isLoading: true, error: null);
    
    final result = await _repository.getTopVotesPaginated(
      limit: pageSize,
      lastDocumentId: null,
    );
    
    result.fold(
      (failure) {
        AppLogger.e('_loadInitialData 실패: ${failure.message}');
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (voteList) {
        AppLogger.d('_loadInitialData 성공: ${voteList.length}개 투표 로드됨');
        state = state.copyWith(
          votes: voteList,
          isLoading: false,
          hasMore: voteList.length == pageSize,
          lastDocumentId: voteList.isNotEmpty ? voteList.last.id : null,
        );
      },
    );
  }

  /// 추가 데이터 로드
  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;
    
    state = state.copyWith(isLoading: true);
    
    final result = await _repository.getTopVotesPaginated(
      limit: pageSize,
      lastDocumentId: state.lastDocumentId,
    );
    
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (newVoteList) {
        final updatedVotes = [...state.votes, ...newVoteList];
        state = state.copyWith(
          votes: updatedVotes,
          isLoading: false,
          hasMore: newVoteList.length == pageSize,
          lastDocumentId: newVoteList.isNotEmpty ? newVoteList.last.id : null,
        );
      },
    );
  }

  /// 데이터 새로고침
  Future<void> refresh() async {
    state = const VotingPaginationState();
    await _loadInitialData();
  }

  /// 특정 투표 삭제
  Future<void> deleteVote(String voteId, String userId) async {
    final result = await _repository.deleteVote(voteId: voteId, userId: userId);
    
    result.fold(
      (failure) {
        // 삭제 실패 시 에러 표시
        state = state.copyWith(error: failure.message);
      },
      (_) {
        // 삭제 성공 시 목록에서 제거
        final updatedVotes = state.votes.where((vote) => vote.id != voteId).toList();
        state = state.copyWith(votes: updatedVotes);
      },
    );
  }
} 