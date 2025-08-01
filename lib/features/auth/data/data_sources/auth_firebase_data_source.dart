import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:youmr_v2/core/constants/firestore_constants.dart';

/// 인증 및 유저 프로필 관련 Firebase 데이터 소스
/// - 외부 데이터(FirebaseAuth, Firestore, FirebaseStorage)와의 통신만 담당
/// - 예외는 가공하지 않고 그대로 throw
class AuthFirebaseDataSource {
  /// Firebase 인증 인스턴스
  final FirebaseAuth _auth;
  /// Firestore 인스턴스
  final FirebaseFirestore _firestore;
  /// Firebase Storage 인스턴스
  final FirebaseStorage _storage;

  /// [auth], [firestore], [storage]는 DI로 주입 가능(테스트 용이성)
  AuthFirebaseDataSource({
    FirebaseAuth? auth, 
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
  }) : _auth = auth ?? FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance,
       _storage = storage ?? FirebaseStorage.instance;

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

  /// Firebase Storage에 프로필 이미지 업로드
  /// [uid]: 유저 고유 ID
  /// [imageFile]: 업로드할 이미지 파일
  /// 반환: 업로드된 이미지 URL
  /// 예외: 업로드 실패 시 throw
  Future<String> uploadProfileImage({required String uid, required File imageFile}) async {
    final String fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final Reference storageRef = _storage.ref().child('profile_images/$uid/$fileName');
    
    final UploadTask uploadTask = storageRef.putFile(imageFile);
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    
    return downloadUrl;
  }

  /// Firebase Storage에서 프로필 이미지 삭제
  /// [imageUrl]: 삭제할 이미지 URL
  /// 예외: 삭제 실패 시 throw
  Future<void> deleteProfileImage({required String imageUrl}) async {
    try {
      final Reference storageRef = _storage.refFromURL(imageUrl);
      await storageRef.delete();
    } catch (e) {
      // 이미지가 존재하지 않는 경우는 무시
      if (e.toString().contains('object does not exist')) {
        return;
      }
      rethrow;
    }
  }

  /// Firebase Storage에서 유저의 모든 프로필 이미지 삭제
  /// [uid]: 유저 고유 ID
  /// 예외: 삭제 실패 시 throw
  Future<void> deleteAllProfileImages({required String uid}) async {
    try {
      final Reference folderRef = _storage.ref().child('profile_images/$uid');
      final ListResult result = await folderRef.listAll();
      
      for (final Reference fileRef in result.items) {
        await fileRef.delete();
      }
    } catch (e) {
      // 폴더가 존재하지 않는 경우는 무시
      if (e.toString().contains('object does not exist')) {
        return;
      }
      rethrow;
    }
  }
} 