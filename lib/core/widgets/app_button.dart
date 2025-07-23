import 'package:flutter/material.dart';

/// 앱 전역에서 사용하는 메인 버튼 위젯
/// - 검정 배경, 흰색 굵은 글씨, 각진 모서리, 높이 44, 폰트 12, 전체 너비
/// - 비활성화 시 회색 배경
class AppButton extends StatelessWidget {
  final String label; // 버튼에 표시할 텍스트
  final VoidCallback? onPressed; // 버튼 클릭 시 동작
  final bool enabled; // 활성/비활성 상태
  final double height; // 버튼 높이(기본값 44)
  final double fontSize; // 폰트 크기(기본값 12)

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.enabled = true,
    this.height = 48,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: enabled ? Colors.black : Colors.grey.shade400,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // 각진 모서리
          ),
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
} 