import 'package:flutter/material.dart';

/// 프로필 설정 관련 유틸리티 함수
class ProfileSetupUtils {
  /// 에러 메시지 스낵바 표시
  /// [context]: BuildContext
  /// [message]: 에러 메시지
  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// 성공 메시지 스낵바 표시
  /// [context]: BuildContext
  /// [message]: 성공 메시지
  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  /// 폼 유효성 검사
  /// [formKey]: 폼 키
  /// [userType]: 선택된 회원 타입
  /// [dayOfWeek]: 선택된 요일
  /// [context]: BuildContext
  /// 반환: 유효성 검사 통과 여부
  static bool validateForm(
    GlobalKey<FormState> formKey,
    String? userType,
    String? dayOfWeek,
    BuildContext context,
  ) {
    if (!formKey.currentState!.validate()) return false;
    
    if (userType == null) {
      showError(context, '회원 타입을 선택해 주세요.');
      return false;
    }
    
    if (userType == 'offline_member' && dayOfWeek == null) {
      showError(context, '요일을 선택해 주세요.');
      return false;
    }
    
    return true;
  }
} 