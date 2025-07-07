import 'package:intl/intl.dart';

/// 날짜 관련 유틸 함수 모음
class DateUtils {
  /// 현재 날짜 기준 주차(weekOfYear) 반환
  static int getCurrentWeekOfYear() {
    final now = DateTime.now();
    final firstDayOfYear = DateTime(now.year, 1, 1);
    final daysOffset = now.weekday - firstDayOfYear.weekday;
    final firstMonday = firstDayOfYear.add(Duration(days: daysOffset));
    final diff = now.difference(firstMonday).inDays;
    return (diff / 7).ceil() + 1;
  }

  /// yyyy-MM-dd 포맷 문자열 반환
  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
} 