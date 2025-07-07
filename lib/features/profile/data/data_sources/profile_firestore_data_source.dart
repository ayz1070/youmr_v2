import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/profile_entity.dart';

/// Firestore 기반 프로필 데이터소스
class ProfileFirestoreDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ProfileFirestoreDataSource({FirebaseFirestore? firestore, FirebaseAuth? auth})
      : firestore = firestore ?? FirebaseFirestore.instance,
        auth = auth ?? FirebaseAuth.instance;

  /// 내 프로필 조회
  Future<ProfileEntity?> fetchProfile() async {
    final user = auth.currentUser;
    if (user == null) return null;
    final doc = await firestore.collection('users').doc(user.uid).get();
    final data = doc.data();
    if (data == null) return null;
    return ProfileEntity.fromJson({...data, 'id': doc.id});
  }

  /// 내 프로필 수정
  Future<void> updateProfile(ProfileEntity profile) async {
    await firestore.collection('users').doc(profile.id).update(profile.toJson());
  }
} 