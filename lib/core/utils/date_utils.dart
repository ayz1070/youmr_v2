/// 날짜 관련 유틸리티 클래스
class DateUtils {
  /// weekKey(예: '2025-07-07~2025-07-13')를 '7월 7일~7월 13일'로 가공
  static String formatWeekKey(String weekKey) {
    if (weekKey.isEmpty || !weekKey.contains('~')) return '';
    final parts = weekKey.split('~');
    if (parts.length != 2) return '';
    final start = parts[0].trim();
    final end = parts[1].trim();
    // '2025-07-07' → 7월 7일
    String format(String dateStr) {
      final dateParts = dateStr.split('-');
      if (dateParts.length != 3) return '';
      final month = int.tryParse(dateParts[1]) ?? 0;
      final day = int.tryParse(dateParts[2]) ?? 0;
      return '${month}월 ${day}일';
    }
    return '${format(start)}~${format(end)}';
  }
} 