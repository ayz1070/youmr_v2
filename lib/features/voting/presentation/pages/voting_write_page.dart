import 'package:flutter/material.dart';

/// 곡 등록 화면
class VotingWritePage extends StatelessWidget {
  const VotingWritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('곡 등록'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 제목 입력
            TextFormField(
              decoration: const InputDecoration(labelText: '제목'),
              // TODO: validator, controller
            ),
            const SizedBox(height: 16),
            // 가수 입력
            TextFormField(
              decoration: const InputDecoration(labelText: '가수'),
              // TODO: validator, controller
            ),
            const SizedBox(height: 16),
            // YouTube 링크 입력
            TextFormField(
              decoration: const InputDecoration(labelText: 'YouTube 링크 (선택)'),
              // TODO: validator, controller
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // TODO: 곡 등록 처리
              },
              child: const Text('등록'),
            ),
          ],
        ),
      ),
    );
  }
} 