import 'package:flutter/material.dart';

/// 공통 빈 상태 위젯
/// - message: 사용자에게 보여줄 메시지(기본값: '데이터가 없습니다.')
class AppEmptyView extends StatelessWidget {
  final String message;
  const AppEmptyView({super.key, this.message = '데이터가 없습니다.'});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
} 