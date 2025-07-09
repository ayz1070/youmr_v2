import 'package:flutter/material.dart';

/// 공통 로딩 인디케이터 위젯
class AppLoadingView extends StatelessWidget {
  const AppLoadingView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
} 