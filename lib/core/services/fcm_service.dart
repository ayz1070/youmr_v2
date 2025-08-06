import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// FCM 서비스를 관리하는 클래스
class FcmService {
  static final FcmService _instance = FcmService._internal();
  factory FcmService() => _instance;
  FcmService._internal();

  /// Firebase Messaging 인스턴스
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  
  /// 로컬 알림 플러그인
  final FlutterLocalNotificationsPlugin _localNotifications = 
      FlutterLocalNotificationsPlugin();

  /// FCM 초기화 여부
  bool _isInitialized = false;

  /// 포그라운드 메시지 핸들러
  Function(RemoteMessage)? _foregroundMessageHandler;

  /// 토큰 갱신 핸들러
  Function(String)? _tokenRefreshHandler;

  /// FCM 초기화
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // 권한 요청
      await _requestPermission();
      
      // 로컬 알림 초기화
      await _initializeLocalNotifications();
      
      // 백그라운드 메시지 핸들러 등록
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      
      // 포그라운드 메시지 핸들러 등록
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
      
      // 앱이 백그라운드에서 열렸을 때 메시지 핸들러 등록
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
      
      // 앱이 종료된 상태에서 알림을 통해 열렸을 때 핸들러 등록
      RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
      if (initialMessage != null) {
        _handleMessageOpenedApp(initialMessage);
      }

      _isInitialized = true;
      debugPrint('FCM 초기화 완료');
    } catch (e) {
      debugPrint('FCM 초기화 실패: $e');
    }
  }

  /// 알림 권한 요청
  Future<void> _requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint('알림 권한 상태: ${settings.authorizationStatus}');
  }

  /// 로컬 알림 초기화
  Future<void> _initializeLocalNotifications() async {
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

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
  }

  /// FCM 토큰 획득
  Future<String?> getToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      debugPrint('FCM 토큰: $token');
      return token;
    } catch (e) {
      debugPrint('FCM 토큰 획득 실패: $e');
      return null;
    }
  }

  /// 토큰 갱신 리스너 등록
  void onTokenRefresh(Function(String) callback) {
    _tokenRefreshHandler = callback;
    _firebaseMessaging.onTokenRefresh.listen((token) {
      debugPrint('FCM 토큰 갱신: $token');
      callback(token);
    });
  }

  /// 포그라운드 메시지 핸들러 등록
  void onForegroundMessage(Function(RemoteMessage) callback) {
    _foregroundMessageHandler = callback;
  }

  /// 포그라운드 메시지 처리
  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('포그라운드 메시지 수신: ${message.messageId}');
    
    // 로컬 알림 표시
    _showLocalNotification(message);
    
    // 콜백 호출
    _foregroundMessageHandler?.call(message);
  }

  /// 앱이 백그라운드에서 열렸을 때 메시지 처리
  void _handleMessageOpenedApp(RemoteMessage message) {
    debugPrint('백그라운드에서 앱 열림: ${message.messageId}');
    // TODO: 특정 화면으로 네비게이션 처리
  }

  /// 알림 탭 처리
  void _onNotificationTapped(NotificationResponse response) {
    debugPrint('알림 탭됨: ${response.payload}');
    // TODO: 특정 화면으로 네비게이션 처리
  }

  /// 로컬 알림 표시
  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'fcm_default_channel',
      'FCM 기본 채널',
      channelDescription: 'FCM 기본 알림 채널',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? '알림',
      message.notification?.body ?? '',
      platformChannelSpecifics,
      payload: message.data.toString(),
    );
  }

  /// 토큰 삭제 (로그아웃 시 사용)
  Future<void> deleteToken() async {
    try {
      await _firebaseMessaging.deleteToken();
      debugPrint('FCM 토큰 삭제 완료');
    } catch (e) {
      debugPrint('FCM 토큰 삭제 실패: $e');
    }
  }
}

/// 백그라운드 메시지 핸들러 (최상위 레벨 함수여야 함)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('백그라운드 메시지 수신: ${message.messageId}');
  // 백그라운드에서 메시지 수신 시 처리
  // 로컬 알림 표시 등
} 