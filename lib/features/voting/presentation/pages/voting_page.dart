import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/voting_provider.dart';
import 'voting_write_page.dart';

/// 투표 메인 화면 (곡 순위, 투표, 피크얻기)
class VotingPage extends ConsumerWidget {
  const VotingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final votes = ref.watch(votingProvider);
    final notifier = ref.read(votingProvider.notifier);

    if (votes == null) {
      // 로딩 또는 에러 상태
      return const Center(child: CircularProgressIndicator());
    }
    if (votes.isEmpty) {
      // 데이터 없음
      return const Center(child: Text('투표 가능한 곡이 없습니다.'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('투표'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // 곡 등록 화면 이동 (MaterialPageRoute 방식)
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
          Expanded(
            child: ListView.builder(
              itemCount: votes.length,
              itemBuilder: (context, index) {
                final vote = votes[index];
                final selected = notifier.selectedVoteIds.contains(vote.id);
                return ListTile(
                  leading: Text('${index + 1}'),
                  title: Text('${vote.title} - ${vote.artist}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${vote.voteCount}표'),
                      Checkbox(
                        value: selected,
                        onChanged: (_) => notifier.toggleVote(vote.id),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: notifier.selectedVoteIds.isEmpty
                      ? null
                      : () async {
                          final error = await notifier.submitVotes('userId'); // TODO: 실제 로그인 사용자 ID
                          if (error == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('투표가 완료되었습니다')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('에러: $error')),
                            );
                          }
                        },
                  child: const Text('투표하기'),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () async {
                    final error = await notifier.getDailyPick('userId'); // TODO: 실제 로그인 사용자 ID
                    if (error == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('피크가 추가되었습니다')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('에러: $error')),
                      );
                    }
                  },
                  child: const Text('피크얻기'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 