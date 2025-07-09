import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/firestore_constants.dart';

class AttendanceFirestoreDataSource {
  /// Firestore 인스턴스 (DI로 주입)
  final FirebaseFirestore firestore;

  AttendanceFirestoreDataSource({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  /// 내 출석 정보 불러오기
  Future<Map<String, dynamic>?> fetchMyAttendance({
    required String weekKey,
    required String userId,
  }) async {
    final doc = await firestore
        .collection(FirestoreConstants.attendancesCollection)
        .doc('${weekKey}_$userId')
        .get();
    return doc.data();
  }

  /// 내 출석 정보 저장
  Future<void> saveMyAttendance({
    required String weekKey,
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    await firestore
        .collection(FirestoreConstants.attendancesCollection)
        .doc('${weekKey}_$userId')
        .set(data);
  }

  /// 요일별 참석자 스트림 반환
  Stream<List<Map<String, dynamic>>> attendeesByDayStream({
    required String weekKey,
    required String day,
  }) {
    return firestore
        .collection(FirestoreConstants.attendancesCollection)
        .where(FirestoreConstants.weekKey, isEqualTo: weekKey)
        .where(FirestoreConstants.selectedDays, arrayContains: day)
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }

  /// 유저 정보 불러오기
  Future<Map<String, dynamic>?> fetchUserData(String userId) async {
    final doc = await firestore
        .collection(FirestoreConstants.usersCollection)
        .doc(userId)
        .get();
    return doc.data();
  }
} 