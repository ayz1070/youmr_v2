import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/admin_user_entity.dart';

/// Firestore 기반 유저 데이터소스
class UserFirestoreDataSource {
  final FirebaseFirestore firestore;
  UserFirestoreDataSource({FirebaseFirestore? firestore}) : firestore = firestore ?? FirebaseFirestore.instance;

  /// 유저 목록 조회
  Future<List<AdminUserEntity>> fetchUsers() async {
    final snap = await firestore.collection('users').orderBy('createdAt', descending: true).get();
    return snap.docs.map((doc) => AdminUserEntity.fromJson({...doc.data(), 'id': doc.id})).toList();
  }

  /// 유저 권한 변경
  Future<void> changeUserType(String uid, String newType) async {
    await firestore.collection('users').doc(uid).update({'userType': newType});
  }

  /// 유저 삭제
  Future<void> removeUser(String uid) async {
    await firestore.collection('users').doc(uid).delete();
  }
} 