import 'package:cloud_firestore/cloud_firestore.dart';

/// 출석 정보 Firestore 데이터 소스
class AttendanceFirestoreDataSource {
  final FirebaseFirestore _firestore;
  static const String attendanceCollection = 'attendance';
  static const String usersCollection = 'users';

  AttendanceFirestoreDataSource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// 내 출석 정보 불러오기
  Future<Map<String, dynamic>?> fetchMyAttendance({required String weekKey, required String userId}) async {
    final doc = await _firestore.collection(attendanceCollection).doc(' 24{weekKey}_ 24{userId}').get();
    return doc.data();
  }

  /// 내 출석 정보 저장
  Future<void> saveMyAttendance({
    required String weekKey,
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection(attendanceCollection).doc(' 24{weekKey}_ 24{userId}').set(data);
  }

  /// 요일별 참석자 스트림
  Stream<List<Map<String, dynamic>>> attendeesByDayStream({required String weekKey, required String day}) {
    return _firestore
        .collection(attendanceCollection)
        .where('weekKey', isEqualTo: weekKey)
        .where('selectedDays', arrayContains: day)
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }

  /// 유저 정보 불러오기
  Future<Map<String, dynamic>?> fetchUserData(String userId) async {
    final doc = await _firestore.collection(usersCollection).doc(userId).get();
    return doc.data();
  }
} 