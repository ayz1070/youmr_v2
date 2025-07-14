import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youmr_v2/core/constants/firestore_constants.dart';

/// 인증 및 유저 프로필 관련 Firebase 데이터 소스
/// - 외부 데이터(FirebaseAuth, Firestore)와의 통신만 담당
/// - 예외는 가공하지 않고 그대로 throw
class AuthFirebaseDataSource {
  /// Firebase 인증 인스턴스
  final FirebaseAuth _auth;
  /// Firestore 인스턴스
  final FirebaseFirestore _firestore;

  /// [auth], [firestore]는 DI로 주입 가능(테스트 용이성)
  AuthFirebaseDataSource({FirebaseAuth? auth, FirebaseFirestore? firestore})
      : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  /// 구글 로그인
  /// [credential]: 구글 인증 정보
  /// 반환: [UserCredential] (성공 시)
  /// 예외: 인증 실패 시 throw
  Future<UserCredential> signInWithGoogle({required AuthCredential credential}) async {
    return await _auth.signInWithCredential(credential);
  }

  /// 현재 로그인된 유저 반환
  /// 반환: [User] (없으면 null)
  User? getCurrentUser() => _auth.currentUser;

  /// 로그아웃
  /// 예외: 로그아웃 실패 시 throw
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Firestore에 유저 정보 저장/업데이트
  /// [uid]: 유저 고유 ID
  /// [data]: 저장할 데이터(Map)
  /// 예외: 저장 실패 시 throw
  Future<void> saveUserProfile({required String uid, required Map<String, dynamic> data}) async {
    await _firestore
        .collection(FirestoreConstants.usersCollection)
        .doc(uid)
        .set(data, SetOptions(merge: true));
  }

  /// Firestore에서 유저 정보 조회
  /// [uid]: 유저 고유 ID
  /// 반환: 유저 데이터(Map) 또는 null
  /// 예외: 조회 실패 시 throw
  Future<Map<String, dynamic>?> fetchUserProfile({required String uid}) async {
    final DocumentSnapshot<Map<String, dynamic>> doc =
        await _firestore.collection(FirestoreConstants.usersCollection).doc(uid).get();
    return doc.data();
  }
} 