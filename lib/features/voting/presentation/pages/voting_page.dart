import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/primary_app_bar.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
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
    final votes = ref.watch(votingProvider);
    final notifier = ref.read(votingProvider.notifier);
    final pickAsync = ref.watch(pickProvider);
    final authUser = ref.watch(authProvider).value;
    final String userId = authUser?.uid ?? '';

    if (votes == null) {
      // 로딩 또는 에러 상태
      return const Center(child: CircularProgressIndicator());
    }
    
    // 데이터가 없을 때도 AppBar와 Scaffold를 보여줌
    if (votes.isEmpty) {
      return const NoVoteView();
    }

    // 피크 상태 처리
    final int pick = pickAsync.hasValue ? pickAsync.value ?? 0 : 0;
    final bool isPickLoading = pickAsync.isLoading;
    final int selectedCount = notifier.selectedVoteIds.length;
    final bool isVoteButtonEnabled =
        selectedCount > 0 && selectedCount <= pick && !isPickLoading && userId.isNotEmpty;


    return Scaffold(
      appBar: PrimaryAppBar(
        title: 'Week Of 신청곡',
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const VotingWritePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          PickDisplay(pick: pick, isLoading: isPickLoading),
          Expanded(
            child: VotingList(
              votes: votes,
              selectedVoteIds: notifier.selectedVoteIds,
              onToggle: notifier.toggleVote,
            ),
          ),

          VoteActionButtons(
            selectedCount: selectedCount,
            pick: pick,
            isPickLoading: isPickLoading,
            isVoteButtonEnabled: isVoteButtonEnabled,
            onVote: () async {
              final error = await notifier.submitVotes(userId);
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
              final error = await notifier.getDailyPick(userId);
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