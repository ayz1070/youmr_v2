import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/use_cases/get_top_votes.dart';
import '../../../domain/use_cases/submit_votes.dart';
import '../../../domain/use_cases/get_daily_pick.dart';
import '../../../domain/use_cases/register_vote.dart';
import '../../../../../core/errors/voting_failure.dart';
import '../states/voting_state.dart';

/// 투표 관련 상태를 관리하는 Notifier
class VotingNotifier extends StateNotifier<VotingState> {
  final SubmitVotes _submitVotesUseCase;
  final GetDailyPick _getDailyPickUseCase;
  final RegisterVote _registerVoteUseCase;

  /// 생성자에서 UseCase들을 주입받음
  VotingNotifier({
    required GetTopVotes getTopVotesUseCase,
    required SubmitVotes submitVotesUseCase,
    required GetDailyPick getDailyPickUseCase,
    required RegisterVote registerVoteUseCase,
  }) : _submitVotesUseCase = submitVotesUseCase,
       _getDailyPickUseCase = getDailyPickUseCase,
       _registerVoteUseCase = registerVoteUseCase,
       super(const VotingState());

  /// 투표 토글 처리
  Future<void> toggleVote(String voteId) async {
    final currentSelected = List<String>.from(state.selectedVoteIds);
    if (currentSelected.contains(voteId)) {
      currentSelected.remove(voteId);
    } else {
      currentSelected.add(voteId);
    }
    state = state.copyWith(selectedVoteIds: currentSelected);
  }

  /// 투표 제출
  Future<void> submitVotes(String userId, List<String> voteIds) async {
    final result = await _submitVotesUseCase(userId: userId, voteIds: voteIds);
    
    result.fold(
      (failure) {
        state = state.copyWith(error: _getErrorMessage(failure));
      },
      (success) {
        // 성공 시 선택 상태 초기화
        state = state.copyWith(selectedVoteIds: [], error: null);
      },
    );
  }

  /// 데일리 픽 획득
  Future<void> getDailyPick(String userId) async {
    final result = await _getDailyPickUseCase(userId: userId);
    
    result.fold(
      (failure) {
        state = state.copyWith(error: _getErrorMessage(failure));
      },
      (success) {
        // 성공 처리
        state = state.copyWith(error: null);
      },
    );
  }

  /// 투표 등록
  Future<void> registerVote({
    required String title,
    required String artist,
    String? youtubeUrl,
    required String createdBy,
  }) async {
    final result = await _registerVoteUseCase(
      title: title,
      artist: artist,
      youtubeUrl: youtubeUrl,
      createdBy: createdBy,
    );
    
    result.fold(
      (failure) {
        state = state.copyWith(error: _getErrorMessage(failure));
      },
      (success) {
        // 성공 처리
        state = state.copyWith(error: null);
      },
    );
  }

  /// 에러 메시지 변환 헬퍼 메서드
  String _getErrorMessage(VotingFailure failure) {
    return failure.when(
      networkFailure: () => '네트워크 오류가 발생했습니다.',
      pickExceedFailure: () => '보유 피크보다 많은 곡을 선택할 수 없습니다.',
      alreadyPickedFailure: () => '이미 오늘 피크를 받았습니다.',
      alreadyRegisteredFailure: () => '이미 등록된 곡입니다.',
      permissionFailure: () => '권한이 없습니다.',
      voteNotFoundFailure: () => '투표를 찾을 수 없습니다.',
    );
  }
}
