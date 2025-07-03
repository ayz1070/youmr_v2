import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// 관리자 통계 페이지
class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  Future<int> _countCollection(String collection) async {
    final snap = await FirebaseFirestore.instance.collection(collection).count().get();
    return snap.count ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
      future: Future.wait([
        _countCollection('users'),
        _countCollection('posts'),
        _countCollection('attendance'),
      ]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = snapshot.data!;
        return ListView(
          padding: const EdgeInsets.all(24),
          children: [
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('전체 회원 수'),
              trailing: Text('${data[0]}명'),
            ),
            ListTile(
              leading: const Icon(Icons.article),
              title: const Text('전체 게시글 수'),
              trailing: Text('${data[1]}개'),
            ),
            ListTile(
              leading: const Icon(Icons.check_circle),
              title: const Text('출석 데이터(주간) 수'),
              trailing: Text('${data[2]}건'),
            ),
            // TODO: 출석률, 활성회원 등 추가 통계
          ],
        );
      },
    );
  }
} 