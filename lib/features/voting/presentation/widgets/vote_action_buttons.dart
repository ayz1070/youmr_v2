import 'package:flutter/material.dart';

/// 투표/피크 버튼 및 안내 메시지 위젯
class VoteActionButtons extends StatelessWidget {
  final int selectedCount;
  final int pick;
  final bool isPickLoading;
  final bool isVoteButtonEnabled;
  final VoidCallback onVote;
  final VoidCallback onGetPick;
  final String userId;

  const VoteActionButtons({
    super.key,
    required this.selectedCount,
    required this.pick,
    required this.isPickLoading,
    required this.isVoteButtonEnabled,
    required this.onVote,
    required this.onGetPick,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          if (selectedCount > pick && !isPickLoading)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                '선택한 곡 수가 보유 피크보다 많습니다.',
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
            ),
          ElevatedButton(
            onPressed: isVoteButtonEnabled ? onVote : null,
            child: const Text('투표하기'),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: userId.isNotEmpty ? onGetPick : null,
            child: const Text('피크얻기'),
          ),
        ],
      ),
    );
  }
} 