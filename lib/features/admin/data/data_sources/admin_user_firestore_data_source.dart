import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youmr_v2/core/constants/firestore_constants.dart';

/// 관리자/회원 Firestore 데이터 소스
///
/// - Firestore 컬렉션/필드명은 core/constants/firestore_constants.dart에서 상수로 관리
/// - 예외는 가공하지 않고 그대로 throw
/// - 모든 필드/생성자/함수/파라미터/반환값에 한글 주석 필수
class AdminUserFirestoreDataSource {
  /// Firestore 인스턴스
  final FirebaseFirestore _firestore;

  /// 생성자
  /// [firestore] : 외부에서 주입 가능(DI, 테스트 용이)
  AdminUserFirestoreDataSource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// 전체 회원 목록 조회
  /// return: 회원 데이터(Map) 리스트
  Future<List<Map<String, dynamic>>> fetchAllUsers() async {
    final QuerySnapshot<Map<String, dynamic>> snap = await _firestore
        .collection(FirestoreConstants.usersCollection)
        .orderBy(FirestoreConstants.createdAt, descending: true)
        .get();
    return snap.docs.map((d) => d.data()).toList();
  }

  /// 회원 권한 변경
  /// [uid] : 회원 UID
  /// [newType] : 변경할 권한 타입
  Future<void> updateUserType({required String uid, required String newType}) async {
    await _firestore
        .collection(FirestoreConstants.usersCollection)
        .doc(uid)
        .update({FirestoreConstants.userType: newType});
  }

  /// 회원 삭제
  /// [uid] : 회원 UID
  Future<void> deleteUser({required String uid}) async {
    await _firestore
        .collection(FirestoreConstants.usersCollection)
        .doc(uid)
        .delete();
  }
} 