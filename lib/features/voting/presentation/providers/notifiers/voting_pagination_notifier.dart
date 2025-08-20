import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youmr_v2/features/voting/domain/use_cases/get_daily_pick.dart';
import 'package:youmr_v2/features/voting/domain/use_cases/get_top_votes_paginated.dart';
import 'package:youmr_v2/features/voting/domain/use_cases/submit_votes.dart';
import '../../../../../core/constants/app_logger.dart';
import '../../../../../core/errors/voting_failure.dart';
import '../../../domain/use_cases/delete_vote.dart';
import '../states/voting_pagination_state.dart';
import '../../../../auth/di/auth_module.dart';

/// 페이징된 투표 목록 Notifier
class VotingPaginationNotifier extends StateNotifier<VotingPaginationState> {
  final SubmitVotes submitVotesUseCase;
  final GetDailyPick getDailyPickUseCase;
  final GetTopVotesPaginated getTopVotesPaginatedUseCase;
  final DeleteVote deleteVoteUseCase;
  final Ref _ref;

  static const int pageSize = 10;

  /// 생성자에서 UseCase들과 Ref를 주입받음
  VotingPaginationNotifier({
    required this.submitVotesUseCase,
    required this.getDailyPickUseCase,
    required this.getTopVotesPaginatedUseCase,
    required this.deleteVoteUseCase,
    required Ref ref,
  }) : _ref = ref,
       super(const VotingPaginationState()) {
    AppLogger.d('VotingPaginationNotifier 생성됨');
    // 초기 데이터 로드 (다음 프레임에서 실행)
    Future.microtask(() {
      AppLogger.d('초기 데이터 로드 시작');
      _loadInitialData();
    });
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
    final result = await submitVotesUseCase(
      userId: userId,
      voteIds: state.selectedVoteIds,
    );

    return result.fold((failure) => failure, (_) async {
      // 성공 시 선택 상태 초기화
      state = state.copyWith(selectedVoteIds: []);
      
      // 투표 완료 후 목록 새로고침하여 voteCount 업데이트
      Future.microtask(() => _loadInitialData());
      
      // 서버에서 최신 사용자 정보를 가져와서 authProvider 업데이트
      await _refreshUserPickFromServer();
      
      return null;
    });
  }

  /// 일일 피크 획득
  Future<VotingFailure?> getDailyPick(String userId) async {
    final result = await getDailyPickUseCase(userId: userId);
    return result.fold((failure) => failure, (_) {
      // 피크 획득 성공 시 authProvider의 pick 개수 증가
      final authNotifier = _ref.read(authProvider.notifier);
      authNotifier.increasePickCount(1);
      return null;
    });
  }

  /// 초기 데이터 로드
  Future<void> _loadInitialData() async {
    AppLogger.d('_loadInitialData 시작');
    AppLogger.d('현재 상태: isLoading=${state.isLoading}, votes.length=${state.votes.length}, error=${state.error}');
    
    state = state.copyWith(isLoading: true, error: null);

    try {
      AppLogger.d('getTopVotesPaginatedUseCase 호출 시작: limit=$pageSize, lastDocumentId=null');
      
      final result = await getTopVotesPaginatedUseCase(
        limit: pageSize,
        lastDocumentId: null,
      );

      AppLogger.d('getTopVotesPaginatedUseCase 호출 완료');

      result.fold(
        (failure) {
          AppLogger.e('_loadInitialData 실패: ${_getErrorMessage(failure)}');
          state = state.copyWith(
            isLoading: false,
            error: _getErrorMessage(failure),
            hasInitialized: true, // 에러 발생 시에도 초기화 완료 플래그 설정
          );
        },
        (voteList) {
          AppLogger.d('_loadInitialData 성공: ${voteList.length}개 투표 로드됨');
          AppLogger.d('로드된 투표들: ${voteList.map((v) => '${v.title} - ${v.artist}').toList()}');
          
          state = state.copyWith(
            votes: voteList,
            isLoading: false,
            hasMore: voteList.length == pageSize,
            lastDocumentId: voteList.isNotEmpty ? voteList.last.id : null,
            hasInitialized: true, // 초기화 완료 플래그 설정
          );
          
          AppLogger.d('상태 업데이트 완료: isLoading=${state.isLoading}, votes.length=${state.votes.length}, hasInitialized=${state.hasInitialized}');
        },
      );
    } catch (e, stackTrace) {
      AppLogger.e('_loadInitialData에서 예외 발생: $e');
      AppLogger.e('스택 트레이스: $stackTrace');
      
      state = state.copyWith(
        isLoading: false,
        error: '데이터 로드 중 오류가 발생했습니다: $e',
        hasInitialized: true, // 예외 발생 시에도 초기화 완료 플래그 설정
      );
    }
  }

  /// 추가 데이터 로드
  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;
    state = state.copyWith(isLoading: true);

    final result = await getTopVotesPaginatedUseCase(
      limit: pageSize,
      lastDocumentId: state.lastDocumentId,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: _getErrorMessage(failure),
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

  /// 초기 데이터 로드 (한 번만 실행)
  Future<void> initializeData() async {
    if (state.hasInitialized) return; // 이미 초기화되었으면 건너뛰기
    await _loadInitialData();
  }

  /// 데이터 새로고침
  Future<void> refresh() async {
    state = const VotingPaginationState();
    await _loadInitialData();
  }

  /// 특정 투표 삭제
  Future<void> deleteVote(String voteId, String userId) async {
    final result = await deleteVoteUseCase(
      voteId: voteId,
      userId: userId,
    );

    result.fold(
      (failure) {
        // 삭제 실패 시 에러 표시
        state = state.copyWith(error: _getErrorMessage(failure));
      },
      (_) {
        // 삭제 성공 시 목록에서 제거
        final updatedVotes = state.votes
            .where((vote) => vote.id != voteId)
            .toList();
        state = state.copyWith(votes: updatedVotes);
      },
    );
  }

  /// 서버에서 최신 사용자 pick 정보를 가져와서 authProvider 업데이트
  Future<void> _refreshUserPickFromServer() async {
    try {
      final authUser = _ref.read(authProvider).value;
      if (authUser == null) return;
      
      // Firestore에서 최신 사용자 정보 가져오기
      final firestore = FirebaseFirestore.instance;
      final userDoc = await firestore
          .collection('users')
          .doc(authUser.uid)
          .get();
      
      if (userDoc.exists) {
        final userData = userDoc.data();
        final serverPick = userData?['pick'] ?? 0;
        
        // authProvider의 pick 값을 서버 값으로 업데이트
        final authNotifier = _ref.read(authProvider.notifier);
        authNotifier.updatePickCount(serverPick);
        
        AppLogger.d('서버에서 pick 값 동기화 완료: $serverPick');
      }
    } catch (e) {
      AppLogger.e('pick 값 동기화 실패: $e');
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
}
