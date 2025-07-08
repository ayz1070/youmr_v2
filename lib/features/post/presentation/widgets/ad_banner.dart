import 'package:flutter/material.dart';

/// 광고 배너 더미 위젯 (실제 광고 연동 전)
class AdBanner extends StatelessWidget {
  const AdBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber),
      ),
      child: const Center(
        child: Text('광고 배너 자리', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
} 