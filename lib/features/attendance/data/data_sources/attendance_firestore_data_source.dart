import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/attendance_entity.dart';

/// 출석 관련 Firestore 데이터소스
class AttendanceFirestoreDataSource {
  final FirebaseFirestore _firestore;
  AttendanceFirestoreDataSource({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  /// 내 출석 정보 불러오기
  Future<AttendanceEntity?> fetchMyAttendance(String weekKey, String userId) async {
    final doc = await _firestore.collection('attendance').doc('${weekKey}_$userId').get();
    if (!doc.exists) return null;
    return AttendanceEntity.fromJson(doc.data()!);
  }

  /// 출석 정보 저장
  Future<void> saveAttendance(AttendanceEntity entity) async {
    await _firestore.collection('attendance').doc('${entity.weekKey}_${entity.userId}').set(entity.toJson());
  }

  /// 요일별 참석자 스트림
  Stream<List<AttendanceEntity>> attendeesByDay(String weekKey, String day) {
    return _firestore
        .collection('attendance')
        .where('weekKey', isEqualTo: weekKey)
        .where('selectedDays', arrayContains: day)
        .snapshots()
        .map((snap) => snap.docs.map((d) => AttendanceEntity.fromJson(d.data())).toList());
  }
} 