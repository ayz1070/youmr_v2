import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'splash_page.dart';

/// 구글 로그인 버튼이 있는 로그인 화면
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  /// 구글 로그인 및 Firebase Auth 연동 함수
  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      // 구글 로그인 계정 선택
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // 사용자가 로그인 취소
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Firebase Auth 로그인
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) throw Exception('로그인 실패');

      // Firestore에 유저 정보 저장 (최초 로그인 시만)
      final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
      final snapshot = await userDoc.get();
      if (!snapshot.exists) {
        await userDoc.set({
          'uid': user.uid,
          'email': user.email,
          'nickname': user.displayName ?? '',
          'profileImageUrl': user.photoURL ?? '',
          'userType': '', // 최초 로그인 시 미설정
          'dayOfWeek': '',
          'fcmToken': '',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      // 로그인 성공 → SplashPage로 이동(자동 분기)
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const SplashPage()),
        );
      }
    } catch (e, stack) {
      // 에러 발생 시 상세한 에러 정보 출력
      debugPrint('구글 로그인 에러: $e');
      debugPrint('스택 트레이스: $stack');

      // 에러 메시지를 SnackBar로도 보여주기 (개발 중에만)
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('구글 로그인 실패: ${e.toString()}'),
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: Center(
        child: ElevatedButton.icon(
          icon: Image.asset('assets/images/google_logo.png', width: 24, height: 24),
          label: const Text('구글로 시작하기'),
          onPressed: () => _signInWithGoogle(context),
        ),
      ),
    );
  }
} 