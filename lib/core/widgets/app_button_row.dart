import 'package:flutter/material.dart';
import 'app_button.dart';

/// 가로로 2개 버튼을 배치하는 공통 위젯
/// - 각 버튼이 Expanded로 1:1 비율
/// - 버튼 사이에 12픽셀 간격
class AppButtonRow extends StatelessWidget {
  final String leftLabel;
  final VoidCallback? onLeftPressed;
  final bool leftEnabled;
  final String rightLabel;
  final VoidCallback? onRightPressed;
  final bool rightEnabled;

  const AppButtonRow({
    super.key,
    required this.leftLabel,
    required this.onLeftPressed,
    this.leftEnabled = true,
    required this.rightLabel,
    required this.onRightPressed,
    this.rightEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppButton(
            text: leftLabel,
            onPressed: onLeftPressed,
            enabled: leftEnabled,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: AppButton(
            text: rightLabel,
            onPressed: onRightPressed,
            enabled: rightEnabled,
            buttonColor: Colors.blue,
          ),
        ),
      ],
    );
  }
} 