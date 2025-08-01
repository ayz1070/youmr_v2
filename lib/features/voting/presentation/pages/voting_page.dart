import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/primary_app_bar.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/voting_pagination_provider.dart';
import '../providers/voting_provider.dart';
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
    final pickAsync = ref.watch(pickProvider);
    final authUser = ref.watch(authProvider).value;
    final String userId = authUser?.uid ?? '';

    // 선택된 투표는 paginationState에서 가져옴
    final selectedVoteIds = paginationState.selectedVoteIds;

    if (paginationState.isLoading && paginationState.votes.isEmpty) {
      // 초기 로딩 상태
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    // 데이터가 없을 때도 AppBar와 Scaffold를 보여줌
    if (paginationState.votes.isEmpty && !paginationState.isLoading) {
      return const NoVoteView();
    }

    // 피크 상태 처리
    final int pick = pickAsync.hasValue ? pickAsync.value ?? 0 : 0;
    final bool isPickLoading = pickAsync.isLoading;
    final int selectedCount = selectedVoteIds.length;
    final bool isVoteButtonEnabled =
        selectedCount > 0 && selectedCount <= pick && !isPickLoading && userId.isNotEmpty;

    return Scaffold(
      appBar: PrimaryAppBar(
        title: 'Week Of 신청곡',
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
          PickDisplay(pick: pick, isLoading: isPickLoading),
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
            pick: pick,
            isPickLoading: isPickLoading,
            isVoteButtonEnabled: isVoteButtonEnabled,
            onVote: () async {
              final error = await paginationNotifier.submitVotes(userId);
              if (!context.mounted) return;
              
              if (error == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('투표가 완료되었습니다')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('에러: ${error.message}')),
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
                  SnackBar(content: Text('에러: ${error.message}')),
                );
              }
            },
            userId: userId,
          ),
        ],
      ),
    );
  }
} 