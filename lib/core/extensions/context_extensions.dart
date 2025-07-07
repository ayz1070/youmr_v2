import 'package:flutter/material.dart';

/// BuildContext 확장 함수 모음
extension ContextExtensions on BuildContext {
  /// MediaQueryData 바로 접근
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// 화면 너비
  double get screenWidth => mediaQuery.size.width;

  /// 화면 높이
  double get screenHeight => mediaQuery.size.height;

  /// ThemeData 바로 접근
  ThemeData get theme => Theme.of(this);

  /// TextTheme 바로 접근
  TextTheme get textTheme => theme.textTheme;

  /// ColorScheme 바로 접근
  ColorScheme get colorScheme => theme.colorScheme;

  /// SnackBar 간편 호출
  void showSnackBar(String message, {Color? backgroundColor}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: backgroundColor),
    );
  }
} 