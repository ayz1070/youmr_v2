import 'package:cloud_firestore/cloud_firestore.dart';

/// 날짜 관련 유틸리티 클래스
class AppDateUtils {
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

  /// 현재 날짜 기준 weekKey(예: '2025-07-07~2025-07-13') 생성
  static String getCurrentWeekKey([DateTime? now]) {
    final base = now ?? DateTime.now();
    final start = base.subtract(Duration(days: base.weekday - 1));
    final end = start.add(const Duration(days: 6));
    String format(DateTime d) =>
        '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
    return '${format(start)}~${format(end)}';
  }

  /// Firestore Timestamp 변환 헬퍼 함수들
  static DateTime? timestampFromJson(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    }
    return null;
  }

}

