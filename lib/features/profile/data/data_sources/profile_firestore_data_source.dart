import 'package:cloud_firestore/cloud_firestore.dart';

/// 프로필 Firestore 데이터 소스
class ProfileFirestoreDataSource {
  final FirebaseFirestore _firestore;
  static const String usersCollection = 'users';

  ProfileFirestoreDataSource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// 내 프로필 정보 불러오기
  Future<Map<String, dynamic>?> fetchMyProfile({required String uid}) async {
    final doc = await _firestore.collection(usersCollection).doc(uid).get();
    return doc.data();
  }

  /// 내 프로필 정보 저장
  Future<void> saveMyProfile({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection(usersCollection).doc(uid).update(data);
  }
} 