import 'package:cloud_firestore/cloud_firestore.dart';

/// 관리자/회원 Firestore 데이터 소스
class AdminUserFirestoreDataSource {
  final FirebaseFirestore _firestore;
  static const String usersCollection = 'users';

  AdminUserFirestoreDataSource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// 전체 회원 목록 조회
  Future<List<Map<String, dynamic>>> fetchAllUsers() async {
    final snap = await _firestore.collection(usersCollection).orderBy('createdAt', descending: true).get();
    return snap.docs.map((d) => d.data()).toList();
  }

  /// 회원 권한 변경
  Future<void> updateUserType({required String uid, required String newType}) async {
    await _firestore.collection(usersCollection).doc(uid).update({'userType': newType});
  }

  /// 회원 삭제
  Future<void> deleteUser({required String uid}) async {
    await _firestore.collection(usersCollection).doc(uid).delete();
  }
} 