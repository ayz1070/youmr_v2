import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart';
import 'profile_setup_page.dart';
import '../../../main/presentation/pages/main_navigation_page.dart';

/// 앱 실행 시 최초로 보여지는 스플래시 화면
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  /// 로그인 상태 및 프로필 정보 확인 후 분기
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
      final data = snapshot.data();
      final hasProfile = data != null &&
          (data['nickname'] != null && (data['nickname'] as String).trim().isNotEmpty) &&
          (data['userType'] != null && (data['userType'] as String).trim().isNotEmpty);
      if (!hasProfile) {
        // 프로필 미설정 → 프로필 설정 페이지로 이동
        if (context.mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const ProfileSetupPage()),
          );
        }
      } else {
        // 프로필 설정 완료 → 메인 페이지로 이동
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
          MaterialPageRoute(builder: (_) => const ProfileSetupPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('YouMR', style: TextStyle(fontSize: 32)),
      ),
    );
  }
} 