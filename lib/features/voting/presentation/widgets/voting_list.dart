import 'package:flutter/material.dart';
import 'package:youmr_v2/features/voting/presentation/widgets/voting_item.dart';
import '../../domain/entities/vote.dart';

/// 투표 곡 리스트 위젯
class VotingList extends StatelessWidget {
  final List<Vote> votes;
  final List<String> selectedVoteIds;
  final void Function(String voteId) onToggle;
  final String currentUserId;
  final void Function(String voteId, String songTitle)? onDelete;
  final VoidCallback? onLoadMore;
  final bool isLoadingMore;
  final bool hasMore;

  const VotingList({
    super.key,
    required this.votes,
    required this.selectedVoteIds,
    required this.onToggle,
    required this.currentUserId,
    this.onDelete,
    this.onLoadMore,
    this.isLoadingMore = false,
    this.hasMore = true,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (hasMore && !isLoadingMore && 
            scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 200) {
          onLoadMore?.call();
        }
        return false;
      },
      child: ListView.builder(
        itemCount: votes.length + (hasMore ? 1 : 0),
        itemBuilder: (BuildContext context, int index) {
          if (index == votes.length) {
            // 로딩 인디케이터
            return hasMore
                ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : const SizedBox.shrink();
          }

          final Vote vote = votes[index];
          final bool selected = selectedVoteIds.contains(vote.id);
          
          return VotingItem(
            vote: vote,
            rank: index + 1,
            selected: selected,
            onToggle: onToggle,
            currentUserId: currentUserId,
            onDelete: onDelete != null ? () => onDelete!(vote.id, vote.title) : null,
          );
        },
      ),
    );
  }
} 