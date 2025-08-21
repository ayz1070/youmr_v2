import 'package:flutter/material.dart';
import '../pages/voting_write_page.dart';

/// 투표 데이터 없음 안내 위젯
class NoVoteView extends StatelessWidget {
  const NoVoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('투표'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '투표 가능한 곡이 없습니다.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const VotingWritePage(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('투표 곡 등록하기'),
            ),
          ],
        ),
      ),
    );
  }
} 