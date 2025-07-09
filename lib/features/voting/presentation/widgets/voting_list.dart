import 'package:flutter/material.dart';
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
        return ListTile(
          leading: Text('${index + 1}'),
          title: Text('${vote.title} - ${vote.artist}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('${vote.voteCount}표'),
              Checkbox(
                value: selected,
                onChanged: (_) => onToggle(vote.id),
              ),
            ],
          ),
        );
      },
    );
  }
} 