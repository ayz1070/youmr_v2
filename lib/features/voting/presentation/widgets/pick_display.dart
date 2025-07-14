import 'package:flutter/material.dart';

/// 피크(투표권) 개수 표시 위젯
class PickDisplay extends StatelessWidget {
  final int pick;
  final bool isLoading;

  const PickDisplay({super.key, required this.pick, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: isLoading
          ? const CircularProgressIndicator()
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 투표 아이콘
                Icon(Icons.how_to_vote, color: Colors.black, size: 24),
                const SizedBox(width: 8),
                // PICK 텍스트
                const Text(
                  'PICK',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Spacer(),
                // 개수
                Text(
                  '$pick개',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
    );
  }
}
