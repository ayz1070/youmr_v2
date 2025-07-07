import 'package:flutter/material.dart';

/// 공통 로딩 인디케이터 위젯
class LoadingIndicator extends StatelessWidget {
  final double size;
  final Color? color;

  const LoadingIndicator({super.key, this.size = 32, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(color ?? Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
} 