import 'package:flutter/material.dart';

/// 피크(투표권) 개수 표시 위젯
class PickDisplay extends StatelessWidget {
  final int pick;
  final bool isLoading;

  const PickDisplay({
    super.key,
    required this.pick,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: isLoading
          ? const CircularProgressIndicator()
          : Text('보유 피크: $pick개', style: const TextStyle(fontSize: 16)),
    );
  }
} 