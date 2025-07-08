import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// 인증 관련 Firebase 데이터 소스
class AuthFirebaseDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthFirebaseDataSource({FirebaseAuth? auth, FirebaseFirestore? firestore})
      : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  /// 구글 로그인
  Future<UserCredential> signInWithGoogle({required AuthCredential credential}) async {
    return await _auth.signInWithCredential(credential);
  }

  /// 현재 로그인 유저 반환
  User? getCurrentUser() => _auth.currentUser;

  /// 로그아웃
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Firestore에 유저 정보 저장/업데이트
  Future<void> saveUserProfile({required String uid, required Map<String, dynamic> data}) async {
    await _firestore.collection('users').doc(uid).set(data, SetOptions(merge: true));
  }

  /// Firestore에서 유저 정보 조회
  Future<Map<String, dynamic>?> fetchUserProfile({required String uid}) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.data();
  }
} 