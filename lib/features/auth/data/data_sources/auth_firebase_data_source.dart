import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../dtos/user_dto.dart';

/// 인증 관련 Firebase 데이터소스
class AuthFirebaseDataSource {
  final fb_auth.FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  AuthFirebaseDataSource({
    fb_auth.FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    GoogleSignIn? googleSignIn,
  })  : _auth = auth ?? fb_auth.FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  /// 구글 로그인 및 Firebase Auth 연동
  Future<UserDTO> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) throw Exception('구글 로그인 취소');
    final googleAuth = await googleUser.authentication;
    final credential = fb_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final userCredential = await _auth.signInWithCredential(credential);
    final user = userCredential.user;
    if (user == null) throw Exception('로그인 실패');
    // Firestore에 유저 정보 저장(최초 로그인 시)
    final userDoc = _firestore.collection('users').doc(user.uid);
    final snapshot = await userDoc.get();
    if (!snapshot.exists) {
      final dto = UserDTO(
        uid: user.uid,
        email: user.email ?? '',
        nickname: user.displayName ?? '',
        profileImageUrl: user.photoURL ?? '',
        userType: '',
        dayOfWeek: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await userDoc.set(dto.toJson());
      return dto;
    } else {
      return UserDTO.fromJson(snapshot.data()!);
    }
  }

  /// 프로필 정보 저장
  Future<void> saveProfile(UserDTO dto) async {
    final userDoc = _firestore.collection('users').doc(dto.uid);
    await userDoc.set(dto.toJson(), SetOptions(merge: true));
  }

  /// 인증 및 프로필 정보 체크
  Future<Map<String, dynamic>?> getCurrentUserProfile() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    final userDoc = _firestore.collection('users').doc(user.uid);
    final snapshot = await userDoc.get();
    return snapshot.data();
  }
} 