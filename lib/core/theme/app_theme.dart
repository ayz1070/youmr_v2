import 'package:flutter/material.dart';

/// Material Design 3 전문가 템플릿 기반 라이트 테마 (Black 메인 컬러)
class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Colors.black, // 메인 색상 (검은색)
      onPrimary: Colors.white, // 메인 색상 위의 텍스트 (흰색)
      secondary: Colors.black, // 보조 색상 (검은색)
      onSecondary: Colors.white, // 보조 색상 위의 텍스트 (흰색)
      tertiary: Colors.black, // 3차 색상 (검은색)
      onTertiary: Colors.white, // 3차 색상 위의 텍스트 (흰색)
      error: Color(0xFFBA1A1A), // 에러 색상
      onError: Colors.white, // 에러 색상 위의 텍스트
      background: Colors.white, // 배경 색상 (흰색)
      onBackground: Colors.black, // 배경 위의 텍스트 (검은색)
      surface: Colors.white, // 표면 색상 (흰색)
      onSurface: Colors.black, // 표면 위의 텍스트 (검은색)
      surfaceVariant: Color(0xFFF5F5F5), // 표면 변형 색상
      onSurfaceVariant: Colors.black, // 표면 변형 위의 텍스트
      outline: Color(0xFF757575), // 외곽선 색상
      outlineVariant: Color(0xFFCAC4D0), // 외곽선 변형 색상
      shadow: Color(0xFF000000), // 그림자 색상
      scrim: Color(0xFF000000), // 스크림 색상
      inverseSurface: Colors.black, // 역 표면 색상
      onInverseSurface: Colors.white, // 역 표면 위의 텍스트
      inversePrimary: Colors.white, // 역 메인 색상
      surfaceTint: Colors.black, // 표면 틴트 색상
    ),
    scaffoldBackgroundColor: Colors.white, // 스캐폴드 배경 (흰색)
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
        backgroundColor: Colors.black, // Black 메인 컬러
        foregroundColor: Colors.white, // White 텍스트
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(48, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
        foregroundColor: Colors.black, // Black 텍스트
        side: const BorderSide(color: Colors.black), // Black 테두리
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(48, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
        backgroundColor: Colors.black, // Black 메인 컬러
        foregroundColor: Colors.white, // White 텍스트
      ),
    ),
    tabBarTheme: const TabBarThemeData(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 2.5, color: Colors.black), // Black 인디케이터
        insets: EdgeInsets.symmetric(horizontal: 24),
      ),
      labelColor: Colors.black, // Black 라벨
      unselectedLabelColor: Color(0xFF757575),
      labelStyle: TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Montserrat'),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0x1A000000),
      thickness: 1,
      space: 32,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white, // 흰색 배경
      foregroundColor: Colors.black, // Black 텍스트
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.black, // Black 제목
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'Montserrat',
      ),
    ),
    splashFactory: InkSparkle.splashFactory, // 자연스러운 머티리얼 모션
    // 접근성: 색상 대비, 터치 타겟, 폰트 크기 등은 시스템 설정에 따름
  );
} 