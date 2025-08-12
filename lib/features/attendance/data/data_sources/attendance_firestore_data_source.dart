import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/firestore_constants.dart';
import '../dtos/attendance_dto.dart';
import 'attendance_data_source.dart';

/// 출석 Firestore 데이터 소스 구현체
/// - Firestore와의 직접적인 통신만 담당
/// - 예외를 가공하지 않고 그대로 throw
/// - DTO 변환 로직 포함
class AttendanceFirestoreDataSource implements AttendanceDataSource {
  /// Firestore 인스턴스 (DI로 주입)
  final FirebaseFirestore _firestore;

  /// 생성자
  /// 
  /// [firestore] Firestore 인스턴스 (기본값: FirebaseFirestore.instance)
  AttendanceFirestoreDataSource({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  /// 내 출석 정보 불러오기
  @override
  Future<AttendanceDto?> fetchMyAttendance({
    required String weekKey,
    required String userId,
  }) async {
    final String documentId = '${weekKey}_$userId';
    
    try {
      final DocumentSnapshot<Map<String, dynamic>> doc = 
          await _firestore
              .collection(FirestoreConstants.attendancesCollection)
              .doc(documentId)
              .get();
      
      if (!doc.exists || doc.data() == null) {
        return null;
      }
      
      final Map<String, dynamic> data = doc.data()!;
      return AttendanceDto.fromJson(data);
    } catch (e) {
      // DataSource에서는 예외를 그대로 throw
      rethrow;
    }
  }

  /// 내 출석 정보 저장
  @override
  Future<void> saveMyAttendance({
    required String weekKey,
    required String userId,
    required AttendanceDto data,
  }) async {
    final String documentId = '${weekKey}_$userId';
    
    try {
      final Map<String, dynamic> jsonData = data.toJson();
      await _firestore
          .collection(FirestoreConstants.attendancesCollection)
          .doc(documentId)
          .set(jsonData);
    } catch (e) {
      // DataSource에서는 예외를 그대로 throw
      rethrow;
    }
  }

  /// 요일별 참석자 스트림 반환
  @override
  Stream<List<AttendanceDto>> attendeesByDayStream({
    required String weekKey,
    required String day,
  }) {
    try {
      return _firestore
          .collection(FirestoreConstants.attendancesCollection)
          .where(FirestoreConstants.weekKey, isEqualTo: weekKey)
          .where(FirestoreConstants.selectedDays, arrayContains: day)
          .snapshots()
          .map((QuerySnapshot<Map<String, dynamic>> snap) => 
              snap.docs
                  .map((QueryDocumentSnapshot<Map<String, dynamic>> d) {
                    final Map<String, dynamic> data = d.data();
                    return AttendanceDto.fromJson(data);
                  })
                  .toList());
    } catch (e) {
      // DataSource에서는 예외를 그대로 throw
      rethrow;
    }
  }

  /// 유저 정보 불러오기
  @override
  Future<Map<String, dynamic>?> fetchUserData(String userId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> doc = 
          await _firestore
              .collection(FirestoreConstants.usersCollection)
              .doc(userId)
              .get();
      
      return doc.data();
    } catch (e) {
      // DataSource에서는 예외를 그대로 throw
      rethrow;
    }
  }
} 