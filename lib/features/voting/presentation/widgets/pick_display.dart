import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/di/auth_module.dart';

/// 피크(투표권) 개수 표시 위젯
class PickDisplay extends ConsumerWidget {
  const PickDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // authProvider에서 pick 값을 실시간으로 가져오기
    final authUser = ref.watch(authProvider).value;
    final int pick = authUser?.pick ?? 0;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
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
