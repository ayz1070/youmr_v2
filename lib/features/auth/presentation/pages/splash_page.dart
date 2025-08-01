import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart';
import 'profile_setup_page.dart';
import '../../../main/presentation/pages/main_navigation_page.dart';

/// 앱 실행 시 최초로 보여지는 스플래시 화면
class SplashPage extends StatefulWidget {
  /// [key]: 위젯 고유 키
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

/// 스플래시 페이지 상태 클래스
class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  /// 로그인 상태 및 프로필 정보 확인 후 분기
  /// Firestore/FirebaseAuth 직접 접근 → 추후 Provider 구조로 개선 권장
  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 1)); // 스플래시 연출용
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // 로그인 X → 로그인 페이지로 이동
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
      return;
    }
    try {
      // Firestore에서 프로필 정보 확인
      final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
      final snapshot = await userDoc.get();
      
      // 문서 존재 여부 확인
      if (!snapshot.exists) {
        debugPrint('사용자 프로필 문서가 존재하지 않음: ${user.uid}');
        // 프로필 문서 없음 → 프로필 설정 페이지로 이동
        if (context.mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginPage()),
          );
        }
        return;
      }
      
      // 문서 데이터 확인
      final data = snapshot.data();
      if (data == null) {
        debugPrint('사용자 프로필 데이터가 null: ${user.uid}');
        // 데이터가 null → 프로필 설정 페이지로 이동
        if (context.mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginPage()),
          );
        }
        return;
      }
      
      // 필수 프로필 정보 확인
      final hasProfile = (data['nickname'] != null && (data['nickname'] as String).trim().isNotEmpty) &&
          (data['userType'] != null && (data['userType'] as String).trim().isNotEmpty);
      
      debugPrint('프로필 정보 확인: nickname=${data['nickname']}, userType=${data['userType']}, hasProfile=$hasProfile');
      
      if (!hasProfile) {
        // 프로필 미설정 → 프로필 설정 페이지로 이동
        debugPrint('프로필 정보가 불완전함 → 프로필 설정 페이지로 이동');
        if (context.mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const ProfileSetupPage()),
          );
        }
      } else {
        // 프로필 설정 완료 → 메인 페이지로 이동
        debugPrint('프로필 정보 완료 → 메인 페이지로 이동');
        if (context.mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const MainNavigationPage()),
          );
        }
      }
    } catch (e) {
      // Firestore 접근 오류 시 → 프로필 설정 페이지로 이동
      debugPrint('Firestore 접근 오류: $e');
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 실제 앱에서는 AppLoadingView 등 core/widgets 공통 위젯 사용 권장
    return const Scaffold(
      body: Center(
        child: Text('YouMR', style: TextStyle(fontSize: 32)), // 문구 상수화 권장
      ),
    );
  }
} 