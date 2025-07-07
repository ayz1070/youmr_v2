/// 문자열 관련 유틸 함수 모음
class StringUtils {
  /// null 또는 빈 문자열 여부 반환
  static bool isNullOrEmpty(String? value) => value == null || value.isEmpty;

  /// 첫 글자 대문자 변환
  static String capitalize(String value) => value.isEmpty ? value : value[0].toUpperCase() + value.substring(1);
} 