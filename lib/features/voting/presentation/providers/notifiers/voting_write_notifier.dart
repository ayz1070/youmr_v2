import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youmr_v2/features/voting/domain/use_cases/register_vote.dart';
import '../../../../../core/errors/voting_failure.dart';
import '../states/voting_write_state.dart';

/// 투표 작성 Notifier
class VotingWriteNotifier extends StateNotifier<VotingWriteState> {
  final RegisterVote _registerVoteUseCase;
  
  /// 생성자에서 RegisterVote UseCase를 주입받음
  VotingWriteNotifier({
    required RegisterVote registerVoteUseCase,
  }) : _registerVoteUseCase = registerVoteUseCase,
       super(const VotingWriteState.initial());
  
  /// 투표 등록 처리
  Future<void> registerVote({
    required String title,
    required String artist,
    String? youtubeUrl,
    required String createdBy,
  }) async {
    state = const VotingWriteState.loading();
    
    try {
      final result = await _registerVoteUseCase(
        title: title,
        artist: artist,
        youtubeUrl: youtubeUrl,
        createdBy: createdBy,
      );
      
      result.fold(
        (failure) {
          state = VotingWriteState.error(_getErrorMessage(failure));
        },
        (_) {
          state = const VotingWriteState.success();
        },
      );
    } catch (e) {
      state = VotingWriteState.error('알 수 없는 오류가 발생했습니다: $e');
    }
  }

  /// 에러 메시지 변환
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

  /// 상태 초기화
  void reset() {
    state = const VotingWriteState.initial();
  }
}
