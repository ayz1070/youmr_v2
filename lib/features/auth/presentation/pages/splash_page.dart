import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youmr_v2/core/services/fcm_service.dart';
import 'package:youmr_v2/core/constants/app_logger.dart';

import 'package:youmr_v2/features/notification/presentation/providers/notification_provider.dart';
import '../../di/auth_module.dart';
import 'login_page.dart';
import 'profile_setup_page.dart';

import '../../../main/presentation/pages/main_navigation_page.dart';

/// 앱 실행 시 최초로 보여지는 스플래시 화면
class SplashPage extends ConsumerStatefulWidget {
  /// [key]: 위젯 고유 키
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

/// 스플래시 페이지 상태 클래스
class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();

    // 빌드 완료 후 인증 확인 실행
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuth();
    });
  }

  /// 로그인 상태 및 프로필 정보 확인 후 분기
  /// Firestore/FirebaseAuth 직접 접근 → 추후 Provider 구조로 개선 권장
  Future<void> _checkAuth() async {
    try {
      // authProvider 초기화 추가 - 사용자 정보 로드
      await ref.read(authProvider.notifier).initialize();
      
      // 딜레이 제거 - 즉시 다음 화면으로 전환
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        // 로그인 X → 로그인 페이지로 이동
        AppLogger.i('사용자 로그인 상태 없음 → 로그인 페이지로 이동');
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginPage()),
          );
        }
        return;
      }
      
      // 로그인된 사용자의 FCM 토큰 저장 및 FCM 서비스 초기화
      await _saveFcmToken();
      await _initializeFcmService();
      
      // Firestore에서 사용자 프로필 정보 확인
      final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
      final snapshot = await userDoc.get();
      
      // 문서 존재 여부 확인
      if (!snapshot.exists) {
        AppLogger.w('사용자 프로필 문서가 존재하지 않음: ${user.uid}');
        // 프로필 문서 없음 → 프로필 설정 페이지로 이동
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const ProfileSetupPage()),
          );
        }
        return;
      }
      
      // 문서 데이터 확인
      final data = snapshot.data();
      if (data == null) {
        AppLogger.w('사용자 프로필 데이터가 null: ${user.uid}');
        // 데이터가 null → 프로필 설정 페이지로 이동
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const ProfileSetupPage()),
          );
        }
        return;
      }
      
      // 필수 프로필 정보 확인 - 더 엄격한 검증
      final nickname = data['nickname'] as String?;
      final userType = data['userType'] as String?;
      
      // 닉네임과 유저타입이 모두 존재하고 의미있는 값인지 확인
      final hasValidNickname = nickname != null && nickname.trim().isNotEmpty && nickname.trim() != '사용자';
      final hasValidUserType = userType != null && userType.trim().isNotEmpty;
      final hasProfile = hasValidNickname && hasValidUserType;
      
      AppLogger.i('프로필 정보 확인: nickname="$nickname", userType="$userType", hasValidNickname=$hasValidNickname, hasValidUserType=$hasValidUserType, hasProfile=$hasProfile');
      
      if (!hasProfile) {
        // 프로필 미설정 → 프로필 설정 페이지로 이동
        AppLogger.i('프로필 정보가 불완전함 → 프로필 설정 페이지로 이동');
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const ProfileSetupPage()),
          );
        }
        return;
      } else {
        // 프로필 설정 완료 → 바로 메인 페이지로 이동
        AppLogger.i('프로필 정보 완료 → 메인 페이지로 이동');
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const MainNavigationPage()),
          );
        }
        return;
      }
    } catch (e) {
      // Firestore 접근 오류 시 → 로그인 페이지로 이동
      AppLogger.e('Firestore 접근 오류: $e');
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
    }
  }

  /// FCM 토큰 저장
  Future<void> _saveFcmToken() async {
    try {
      final fcmService = FcmService();
      final token = await fcmService.getToken();
      
      if (token != null) {
        // Provider를 통해 FCM 토큰 저장
        await ref.read(notificationProvider.notifier).saveFcmToken(token);
        AppLogger.i('FCM 토큰 저장 완료: $token');
        
        // FCM 토큰 갱신 리스너 등록
        fcmService.onTokenRefresh((newToken) async {
          await ref.read(notificationProvider.notifier).saveFcmToken(newToken);
          AppLogger.i('FCM 토큰 갱신 및 저장 완료: $newToken');
        });
      }
    } catch (e) {
      AppLogger.e('FCM 토큰 저장 실패: $e');
    }
  }

  /// FCM 서비스 초기화
  Future<void> _initializeFcmService() async {
    try {
      final fcmService = FcmService();
      
      // 포그라운드 메시지 핸들러 등록
      fcmService.onForegroundMessage((message) {
        AppLogger.i('포그라운드 FCM 메시지 수신: ${message.messageId}');
        // TODO: 필요시 특정 화면으로 네비게이션 처리
        // 예: 투표 알림이면 투표 페이지로, 출석 알림이면 출석 페이지로
      });
      
      // 알림 설정 로드
      await ref.read(notificationProvider.notifier).loadNotificationSettings();
      
      AppLogger.i('FCM 서비스 초기화 완료');
    } catch (e) {
      AppLogger.e('FCM 서비스 초기화 실패: $e');
      // FCM 초기화 실패해도 앱은 계속 진행
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 상단 여백
            Expanded(
              flex: 1,
              child: Container(),
            ),
            
            // 중앙 텍스트 영역
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // You Make 텍스트
                  Text(
                    'You Make',
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.12, // 화면 너비의 12%
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  
                  const SizedBox(height: 8), // 텍스트 간격
                  
                  // Rhythm 텍스트
                  Text(
                    'Rhythm',
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.12, // 화면 너비의 12%
                      fontWeight: FontWeight.w700,
                      color: Colors.grey, // 더 진한 회색으로 대비 개선
                    ),
                  ),
                ],
              ),
            ),
            
            // 하단 영역
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // made by Jun 텍스트
                  Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.05), // 하단 여백
                    child: Text(
                      'made by Jun',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.03, // 화면 너비의 3%
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}