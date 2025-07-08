/// 주차(weekKey) 값 객체
class WeekKey {
  final int year;
  final int weekOfYear;

  const WeekKey({required this.year, required this.weekOfYear});

  @override
  String toString() => ' 4{year}- 4{weekOfYear}';

  /// 현재 날짜 기준 weekKey 생성
  factory WeekKey.now() {
    final now = DateTime.now();
    final weekStr = DateTime.now().weekday;
    // 실제 week 계산은 DateFormat 등 활용 가능(간단화)
    return WeekKey(year: now.year, weekOfYear: int.parse(weekStr.toString()));
  }
} 