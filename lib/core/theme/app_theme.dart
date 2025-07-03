import 'package:flutter/material.dart';

/// Material Design 3 전문가 템플릿 기반 라이트 테마
class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFB5B2FF), // 메인 시드 컬러(기본)
      secondary: const Color(0xFFB2EBF4), // 보조 색상
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Montserrat', // Geometric Sans (Modern)
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w700),
      displayMedium: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w700),
      displaySmall: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w700),
      headlineLarge: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
      headlineMedium: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
      titleLarge: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
      titleSmall: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
      bodySmall: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
      labelLarge: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w500, letterSpacing: 0.1),
      labelMedium: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w500, letterSpacing: 0.1),
      labelSmall: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w500, letterSpacing: 0.1),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.zero, // Sharp
      ),
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    ),
    cardTheme: const CardThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Sharp
        side: BorderSide(width: 1.2, color: Color(0x1A000000)), // Outlined
      ),
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      clipBehavior: Clip.antiAlias,
    ),
    buttonTheme: const ButtonThemeData(
      minWidth: 48,
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(48, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
        backgroundColor: const Color(0xFF52F2F2),
        foregroundColor: Colors.black,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(48, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
        foregroundColor: const Color(0xFF52F2F2),
        side: const BorderSide(color: Color(0xFF52F2F2)),
      ),
    ),
    tabBarTheme: const TabBarThemeData(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 2.5, color: Color(0xFFB5B2FF)),
        insets: EdgeInsets.symmetric(horizontal: 24),
      ),
      labelColor: Color(0xFFB5B2FF),
      unselectedLabelColor: Color(0xFF757575),
      labelStyle: TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Montserrat'),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0x1A000000),
      thickness: 1,
      space: 32,
    ),
    splashFactory: InkSparkle.splashFactory, // 자연스러운 머티리얼 모션
    // 접근성: 색상 대비, 터치 타겟, 폰트 크기 등은 시스템 설정에 따름
  );
} 