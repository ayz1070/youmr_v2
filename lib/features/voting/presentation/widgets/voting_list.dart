import 'package:flutter/material.dart';
import 'package:youmr_v2/features/voting/presentation/widgets/voting_item.dart';
import '../../domain/entities/vote.dart';

/// 투표 곡 리스트 위젯
class VotingList extends StatelessWidget {
  final List<Vote> votes;
  final List<String> selectedVoteIds;
  final void Function(String voteId) onToggle;

  const VotingList({
    super.key,
    required this.votes,
    required this.selectedVoteIds,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: votes.length,
      itemBuilder: (BuildContext context, int index) {
        final Vote vote = votes[index];
        final bool selected = selectedVoteIds.contains(vote.id);
        // 커스텀 VotingItem 위젯으로 교체
        return VotingItem(
          vote: vote,
          rank: index + 1,
          selected: selected,
          onToggle: onToggle,
        );
      },
    );
  }
} 