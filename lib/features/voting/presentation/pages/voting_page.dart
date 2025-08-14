import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/primary_app_bar.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../../../core/errors/voting_failure.dart';
import '../../../auth/di/auth_module.dart';
import '../../di/voting_module.dart';
import 'voting_write_page.dart';
import '../widgets/pick_display.dart';
import '../widgets/voting_list.dart';
import '../widgets/vote_action_buttons.dart';
import '../widgets/no_vote_view.dart';

/// 투표 메인 화면 (곡 순위, 투표, 피크얻기)
class VotingPage extends ConsumerWidget {
  const VotingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paginationState = ref.watch(votingPaginationProvider);
    final paginationNotifier = ref.read(votingPaginationProvider.notifier);
    final authUser = ref.watch(authProvider).value;
    final String userId = authUser?.uid ?? '';

    // 선택된 투표는 paginationState에서 가져옴
    final selectedVoteIds = paginationState.selectedVoteIds;

    // 디버그 로그 추가
    print('VotingPage build - isLoading: ${paginationState.isLoading}, votes.length: ${paginationState.votes.length}, error: ${paginationState.error}');

    // Provider가 처음 생성되었을 때 강제로 초기 데이터 로드 시작
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (paginationState.votes.isEmpty && !paginationState.isLoading && paginationState.error == null) {
        print('VotingPage: 강제로 초기 데이터 로드 시작');
        paginationNotifier.refresh();
      }
    });

    // 초기 로딩 상태 (데이터가 없고 로딩 중일 때)
    if (paginationState.isLoading && paginationState.votes.isEmpty && paginationState.error == null) {
      print('VotingPage: 초기 로딩 상태 표시');
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    // 에러 상태
    if (paginationState.error != null && paginationState.votes.isEmpty) {
      print('VotingPage: 에러 상태 표시 - ${paginationState.error}');
      return Scaffold(
        appBar: PrimaryAppBar(title: '신청곡'),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('오류가 발생했습니다: ${paginationState.error}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => paginationNotifier.refresh(),
                child: const Text('다시 시도'),
              ),
            ],
          ),
        ),
      );
    }
    
    // 데이터가 없을 때도 AppBar와 Scaffold를 보여줌
    if (paginationState.votes.isEmpty && !paginationState.isLoading) {
      print('VotingPage: 빈 데이터 상태 표시');
      return Scaffold(
        appBar: PrimaryAppBar(title: '신청곡'),
        body: const NoVoteView(),
      );
    }

    // 선택된 투표 개수
    final int selectedCount = selectedVoteIds.length;

    return Scaffold(
      appBar: PrimaryAppBar(
        title: '신청곡',
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            onPressed: () async {
              final result = await Navigator.of(context).push<bool>(
                MaterialPageRoute(
                  builder: (_) => const VotingWritePage(),
                ),
              );
              
              // 곡이 추가되었다면 목록 새로고침
              if (result == true) {
                paginationNotifier.refresh();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const PickDisplay(),
          Expanded(
            child: VotingList(
              votes: paginationState.votes,
              selectedVoteIds: selectedVoteIds,
              onToggle: (voteId) {
                // 선택 상태 토글
                paginationNotifier.toggleVote(voteId);
              },
              currentUserId: userId,
              onDelete: (voteId, songTitle) async {
                // 삭제 확인 다이얼로그
                final confirmed = await AppDialogHelper.showDeleteVoteDialog(
                  context: context,
                  songTitle: songTitle,
                );

                if (confirmed == true) {
                  await paginationNotifier.deleteVote(voteId, userId);
                  if (!context.mounted) return;
                  
                  if (paginationState.error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(paginationState.error!)),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('곡이 삭제되었습니다.')),
                    );
                  }
                }
              },
              onLoadMore: () => paginationNotifier.loadMore(),
              isLoadingMore: paginationState.isLoading,
              hasMore: paginationState.hasMore,
            ),
          ),

          VoteActionButtons(
            selectedCount: selectedCount,
            onVote: () async {
              final error = await paginationNotifier.submitVotes(userId);
              if (!context.mounted) return;
              
              if (error == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('투표가 완료되었습니다')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('에러: ${_getErrorMessage(error)}')),
                );
              }
            },
            onGetPick: () async {
              final error = await paginationNotifier.getDailyPick(userId);
              if (!context.mounted) return;
              
              if (error == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('피크가 추가되었습니다')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('에러: ${_getErrorMessage(error)}')),
                );
              }
            },
            userId: userId,
          ),
        ],
      ),
    );
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