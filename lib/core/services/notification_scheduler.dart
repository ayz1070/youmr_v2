import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

/// 알림 스케줄러 서비스
class NotificationScheduler {
  static final NotificationScheduler _instance = NotificationScheduler._internal();
  factory NotificationScheduler() => _instance;
  NotificationScheduler._internal();

  /// 로컬 알림 플러그인
  final FlutterLocalNotificationsPlugin _localNotifications = 
      FlutterLocalNotificationsPlugin();

  /// 초기화 여부
  bool _isInitialized = false;

  /// 초기화
  Future<void> initialize() async {
    if (_isInitialized) return;

    // 타임존 초기화
    tz.initializeTimeZones();

    // 로컬 알림 초기화
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(initializationSettings);

    _isInitialized = true;
    debugPrint('알림 스케줄러 초기화 완료');
  }

  /// 출석 체크 알림 스케줄링
  Future<void> scheduleAttendanceReminder({
    required String userId,
    required int dayOfWeek,
    required TimeOfDay time,
  }) async {
    if (!_isInitialized) await initialize();

    try {
      // 기존 알림 취소
      await cancelScheduledNotifications(userId, 'attendance');

      // 새로운 알림 스케줄링
      final now = DateTime.now();
      final scheduledDate = _getNextWeekday(now, dayOfWeek, time);
      
      await _localNotifications.zonedSchedule(
        _getNotificationId(userId, 'attendance'),
        '출석 체크 알림',
        '오늘 출석 체크를 해주세요!',
        tz.TZDateTime.from(scheduledDate, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'attendance_reminder',
            '출석 체크 알림',
            channelDescription: '매주 지정된 요일과 시간에 출석 체크 알림',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@drawable/ic_notification', // 알림 전용 아이콘 사용
            color: Color(0xFF4CAF50), // 출석 알림 색상 (Material Green)
            enableLights: true, // LED 알림 활성화
            enableVibration: true, // 진동 활성화
            playSound: true, // 소리 재생
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        payload: 'attendance_reminder',
      );

      debugPrint('출석 체크 알림 스케줄링 완료: ${scheduledDate.toString()}');
    } catch (e) {
      debugPrint('출석 체크 알림 스케줄링 실패: $e');
    }
  }

  /// 회비 알림 스케줄링
  Future<void> scheduleMonthlyFeeReminder({
    required String userId,
    required int dayOfMonth, // 매월 1일
  }) async {
    if (!_isInitialized) await initialize();

    try {
      // 기존 알림 취소
      await cancelScheduledNotifications(userId, 'monthly_fee');

      // 새로운 알림 스케줄링
      final now = DateTime.now();
      final scheduledDate = _getNextMonthDay(now, dayOfMonth);
      
      await _localNotifications.zonedSchedule(
        _getNotificationId(userId, 'monthly_fee'),
        '회비 납부 알림',
        '이번 달 회비를 납부해주세요!',
        tz.TZDateTime.from(scheduledDate, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'monthly_fee_reminder',
            '회비 납부 알림',
            channelDescription: '매월 1일에 회비 납부 알림',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@drawable/ic_notification', // 알림 전용 아이콘 사용
            color: Color(0xFFFF9800), // 회비 알림 색상 (Material Orange)
            enableLights: true, // LED 알림 활성화
            enableVibration: true, // 진동 활성화
            playSound: true, // 소리 재생
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
        payload: 'monthly_fee_reminder',
      );

      debugPrint('회비 알림 스케줄링 완료: ${scheduledDate.toString()}');
    } catch (e) {
      debugPrint('회비 알림 스케줄링 실패: $e');
    }
  }

  /// 알림 스케줄 취소
  Future<void> cancelScheduledNotifications(String userId, String type) async {
    if (!_isInitialized) await initialize();

    try {
      await _localNotifications.cancel(_getNotificationId(userId, type));
      debugPrint('알림 스케줄 취소 완료: $userId - $type');
    } catch (e) {
      debugPrint('알림 스케줄 취소 실패: $e');
    }
  }

  /// 사용자의 모든 예약된 알림 취소
  Future<void> cancelAllScheduledNotifications(String userId) async {
    if (!_isInitialized) await initialize();

    try {
      await cancelScheduledNotifications(userId, 'attendance');
      await cancelScheduledNotifications(userId, 'monthly_fee');
      debugPrint('모든 알림 스케줄 취소 완료: $userId');
    } catch (e) {
      debugPrint('모든 알림 스케줄 취소 실패: $e');
    }
  }

  /// 다음 주 특정 요일과 시간 계산
  DateTime _getNextWeekday(DateTime now, int dayOfWeek, TimeOfDay time) {
    final currentWeekday = now.weekday;
    int daysToAdd = dayOfWeek - currentWeekday;
    
    if (daysToAdd <= 0) {
      daysToAdd += 7; // 다음 주로 이동
    }

    final nextWeekday = now.add(Duration(days: daysToAdd));
    return DateTime(
      nextWeekday.year,
      nextWeekday.month,
      nextWeekday.day,
      time.hour,
      time.minute,
    );
  }

  /// 다음 달 특정 일자 계산
  DateTime _getNextMonthDay(DateTime now, int dayOfMonth) {
    DateTime nextMonth;
    
    if (now.month == 12) {
      nextMonth = DateTime(now.year + 1, 1, dayOfMonth);
    } else {
      nextMonth = DateTime(now.year, now.month + 1, dayOfMonth);
    }

    // 해당 월에 해당 일자가 없는 경우 (예: 2월 30일) 마지막 날로 조정
    if (nextMonth.month != (now.month == 12 ? 1 : now.month + 1)) {
      nextMonth = DateTime(nextMonth.year, nextMonth.month - 1, 1)
          .add(const Duration(days: 32))
          .copyWith(day: 1)
          .subtract(const Duration(days: 1))
          .copyWith(day: dayOfMonth);
    }

    return DateTime(
      nextMonth.year,
      nextMonth.month,
      nextMonth.day,
      9, // 오전 9시
      0,
    );
  }

  /// 알림 ID 생성
  int _getNotificationId(String userId, String type) {
    return '${userId}_$type'.hashCode;
  }

  /// 조건부 출석 알림 스케줄링 (특정 요일 회원만)
  Future<void> scheduleConditionalAttendanceReminder({
    required String userId,
    required int userDayOfWeek, // 사용자의 출석 요일
    required TimeOfDay time,
  }) async {
    if (!_isInitialized) await initialize();

    try {
      // 사용자의 출석 요일이 토요일(6)인 경우에만 알림 스케줄링
      if (userDayOfWeek == 6) { // 토요일
        await _localNotifications.zonedSchedule(
          _getNotificationId(userId, 'saturday_attendance'),
          '토요일 출석 체크 알림',
          '오늘 토요일 출석 체크를 해주세요!',
          tz.TZDateTime.from(_getNextWeekday(DateTime.now(), 6, time), tz.local),
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'saturday_attendance_reminder',
              '토요일 출석 체크 알림',
              channelDescription: '토요일 출석 체크 알림',
              importance: Importance.high,
              priority: Priority.high,
            ),
            iOS: DarwinNotificationDetails(),
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
          payload: 'saturday_attendance_reminder',
        );
        
        debugPrint('토요일 출석 알림 스케줄링 완료: $userId');
      } else {
        // 토요일이 아닌 경우 토요일 알림 취소
        await cancelScheduledNotifications(userId, 'saturday_attendance');
        debugPrint('토요일이 아닌 사용자 알림 취소: $userId (출석요일: $userDayOfWeek)');
      }
    } catch (e) {
      debugPrint('조건부 출석 알림 스케줄링 실패: $e');
    }
  }

  /// 특정 요일 출석 회원들에게만 알림 스케줄링 (배치 처리)
  Future<void> scheduleDaySpecificAttendanceReminders(int targetDayOfWeek) async {
    if (!_isInitialized) await initialize();

    try {
      // Firestore에서 특정 요일 출석 회원들 조회
      // 실제 구현 시에는 Firestore 쿼리 필요
      final targetUsers = await _getUsersByAttendanceDay(targetDayOfWeek);
      
      for (final user in targetUsers) {
        await scheduleConditionalAttendanceReminder(
          userId: user['id'],
          userDayOfWeek: user['attendanceDayOfWeek'],
          time: const TimeOfDay(hour: 9, minute: 0), // 오전 9시
        );
      }
      
      final dayName = _getDayName(targetDayOfWeek);
      debugPrint('$dayName 출석 알림 스케줄링 완료: ${targetUsers.length}명');
    } catch (e) {
      debugPrint('특정 요일 출석 알림 배치 스케줄링 실패: $e');
    }
  }

  /// 요일 이름 반환
  String _getDayName(int dayOfWeek) {
    switch (dayOfWeek) {
      case 1: return '월요일';
      case 2: return '화요일';
      case 3: return '수요일';
      case 4: return '목요일';
      case 5: return '금요일';
      case 6: return '토요일';
      case 7: return '일요일';
      default: return '알 수 없음';
    }
  }

  /// Firestore에서 특정 요일 출석 회원 조회 (실제 구현 필요)
  Future<List<Map<String, dynamic>>> _getUsersByAttendanceDay(int dayOfWeek) async {
    // TODO: 실제 Firestore 쿼리 구현
    // 예시: FirebaseFirestore.instance.collection('users')
    //   .where('attendanceDayOfWeek', isEqualTo: dayOfWeek)
    //   .get();
    
    // 임시 더미 데이터
    return [
      {'id': 'user1', 'attendanceDayOfWeek': 6},
      {'id': 'user2', 'attendanceDayOfWeek': 6},
    ];
  }
} 