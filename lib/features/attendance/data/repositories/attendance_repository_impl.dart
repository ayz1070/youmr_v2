import 'package:dartz/dartz.dart';
import '../../domain/entities/attendance.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../data_sources/attendance_firestore_data_source.dart';
import '../dtos/attendance_dto.dart';
import '../../../../core/errors/attendance_failure.dart';
import '../../../../core/constants/error_messages.dart';
import '../../../../core/constants/app_logger.dart';
import '../../../../core/constants/firestore_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// 출석 Repository 구현체
/// - Firestore 데이터 소스를 사용하여 출석 데이터 CRUD 작업 수행
/// - 도메인 엔티티와 DTO 간의 변환을 담당
/// - 에러 처리 및 로깅을 통해 안정성 확보
class AttendanceRepositoryImpl implements AttendanceRepository {
  /// Firestore 데이터 소스
  final AttendanceFirestoreDataSource dataSource;
  
  /// 생성자
  /// [dataSource] Firestore 데이터 소스 의존성 주입
  AttendanceRepositoryImpl({required this.dataSource});

  /// 내 출석 정보 조회
  /// [weekKey] 조회할 주차 키
  /// [userId] 조회할 유저 고유 ID
  /// 반환: 성공 시 Attendance 또는 null, 실패 시 AttendanceFailure
  @override
  Future<Either<AttendanceFailure, Attendance?>> getMyAttendance({
    required String weekKey, 
    required String userId
  }) async {
    try {
      final AttendanceDto? dto = await dataSource.fetchMyAttendance(
        weekKey: weekKey, 
        userId: userId
      );
      
      if (dto == null) {
        return const Right(null);
      }
      
      final Attendance attendance = dto.toDomain();
      return Right(attendance);
    } catch (e, st) {
      // 에러 및 스택트레이스 로깅
      AppLogger.e(
        '출석 정보 조회 실패: weekKey=$weekKey, userId=$userId', 
        error: e, 
        stackTrace: st
      );
      return Left(AttendanceFirestoreFailure(
        '${ErrorMessages.attendanceLoadError}: $e'
      ));
    }
  }

  /// 내 출석 정보 저장/수정
  /// [attendance] 저장할 출석 엔티티
  /// 반환: 성공 시 void, 실패 시 AttendanceFailure
  @override
  Future<Either<AttendanceFailure, void>> saveMyAttendance({
    required Attendance attendance
  }) async {
    try {
      final AttendanceDto dto = AttendanceDto.fromDomain(attendance);
      await dataSource.saveMyAttendance(
        weekKey: dto.weekKey,
        userId: dto.userId,
        data: dto,
      );
      return const Right(null);
    } catch (e, st) {
      // 에러 및 스택트레이스 로깅
      AppLogger.e(
        '출석 정보 저장 실패: weekKey=${attendance.weekKey}, userId=${attendance.userId}', 
        error: e, 
        stackTrace: st
      );
      return Left(AttendanceFirestoreFailure(
        '${ErrorMessages.attendanceSaveError}: $e'
      ));
    }
  }

  /// 요일별 참석자 목록 실시간 스트림
  /// [weekKey] 조회할 주차 키
  /// [day] 조회할 요일
  /// 반환: 성공 시 Attendance 리스트 스트림, 실패 시 AttendanceFailure
  @override
  Stream<Either<AttendanceFailure, List<Attendance>>> attendeesByDayStream({
    required String weekKey, 
    required String day
  }) {
    try {
      return dataSource.attendeesByDayStream(weekKey: weekKey, day: day).map((dtoList) {
        final List<Attendance> attendanceList = dtoList
            .map((AttendanceDto dto) => dto.toDomain())
            .toList();
        return Right(attendanceList);
      });
    } catch (e, st) {
      // 에러 및 스택트레이스 로깅
      AppLogger.e(
        '참석자 스트림 실패: weekKey=$weekKey, day=$day', 
        error: e, 
        stackTrace: st
      );
      return Stream.value(Left(AttendanceFirestoreFailure(
        '${ErrorMessages.attendanceStreamError}: $e'
      )));
    }
  }

  /// 현재 사용자 프로필 정보 조회
  /// 반환: 성공 시 (이름, 프로필이미지URL) 튜플, 실패 시 AttendanceFailure
  @override
  Future<Either<AttendanceFailure, (String name, String profileImageUrl)>> 
      getCurrentUserProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        AppLogger.w('사용자 인증 정보가 없습니다');
        return Left(AttendanceFirestoreFailure(ErrorMessages.userNotFoundError));
      }

      // Firestore에서 사용자 정보 가져오기
      final Map<String, dynamic>? userData = await dataSource.fetchUserData(user.uid);
      if (userData == null) {
        AppLogger.w('사용자 프로필 정보를 찾을 수 없습니다: userId=${user.uid}');
        return Left(AttendanceFirestoreFailure(ErrorMessages.userProfileLoadError));
      }

      // name 필드를 우선 사용하고, 없으면 nickname 사용
      final String userName = userData[FirestoreConstants.name] ?? 
                             userData[FirestoreConstants.nickname] ?? 
                             user.displayName ?? 
                             '이름없음';
      final String userProfileImageUrl = userData[FirestoreConstants.profileImageUrl] ?? '';

      return Right((userName, userProfileImageUrl));
    } catch (e, st) {
      AppLogger.e('사용자 프로필 정보 조회 실패', error: e, stackTrace: st);
      return Left(AttendanceFirestoreFailure(
        '${ErrorMessages.userProfileLoadError}: $e'
      ));
    }
  }

  /// 특정 주차의 전체 출석 현황 조회
  /// [weekKey] 조회할 주차 식별자
  /// 반환: 성공 시 전체 출석 목록, 실패 시 AttendanceFailure
  @override
  Future<Either<AttendanceFailure, List<Attendance>>> getWeeklyAttendance({
    required String weekKey,
  }) async {
    try {
      final List<AttendanceDto> dtoList = await dataSource.fetchWeeklyAttendance(
        weekKey: weekKey,
      );
      
      final List<Attendance> attendanceList = dtoList
          .map((dto) => dto.toDomain())
          .toList();
      
      return Right(attendanceList);
    } catch (e, st) {
      AppLogger.e(
        '주간 출석 현황 조회 실패: weekKey=$weekKey', 
        error: e, 
        stackTrace: st
      );
      return Left(AttendanceFirestoreFailure(
        '${ErrorMessages.attendanceLoadError}: $e'
      ));
    }
  }

  /// 사용자별 출석 이력 조회
  /// [userId] 조회할 사용자 ID
  /// [limit] 조회할 최대 기록 수 (기본값: 10)
  /// 반환: 성공 시 출석 이력 목록, 실패 시 AttendanceFailure
  @override
  Future<Either<AttendanceFailure, List<Attendance>>> getUserAttendanceHistory({
    required String userId,
    int limit = 10,
  }) async {
    try {
      final List<AttendanceDto> dtoList = await dataSource.fetchUserAttendanceHistory(
        userId: userId,
        limit: limit,
      );
      
      final List<Attendance> attendanceList = dtoList
          .map((dto) => dto.toDomain())
          .toList();
      
      return Right(attendanceList);
    } catch (e, st) {
      AppLogger.e(
        '사용자 출석 이력 조회 실패: userId=$userId, limit=$limit', 
        error: e, 
        stackTrace: st
      );
      return Left(AttendanceFirestoreFailure(
        '${ErrorMessages.attendanceLoadError}: $e'
      ));
    }
  }

  /// 출석 데이터 삭제
  /// [weekKey] 삭제할 주차 식별자
  /// [userId] 삭제할 사용자 ID
  /// 반환: 성공 시 void, 실패 시 AttendanceFailure
  @override
  Future<Either<AttendanceFailure, void>> deleteAttendance({
    required String weekKey,
    required String userId,
  }) async {
    try {
      await dataSource.deleteAttendance(
        weekKey: weekKey,
        userId: userId,
      );
      
      AppLogger.i('출석 데이터 삭제 성공: weekKey=$weekKey, userId=$userId');
      return const Right(null);
    } catch (e, st) {
      AppLogger.e(
        '출석 데이터 삭제 실패: weekKey=$weekKey, userId=$userId', 
        error: e, 
        stackTrace: st
      );
      return Left(AttendanceFirestoreFailure(
        '${ErrorMessages.attendanceDeleteError}: $e'
      ));
    }
  }
} 