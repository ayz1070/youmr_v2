import 'package:flutter/material.dart';

/// 구글 로그인 버튼 위젯
class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  const GoogleSignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Image.asset('assets/images/google_logo.png', width: 24, height: 24),
      label: const Text('구글로 시작하기'),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        minimumSize: const Size(200, 48),
        side: const BorderSide(color: Color(0xFFB5B2FF)),
      ),
    );
  }
} 