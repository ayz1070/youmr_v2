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
class AttendanceRepositoryImpl implements AttendanceRepository {
  /// Firestore 데이터 소스
  final AttendanceFirestoreDataSource dataSource;
  AttendanceRepositoryImpl({required this.dataSource});

  /// 내 출석 정보 조회
  /// [weekKey] : 주차 키
  /// [userId] : 유저 고유 ID
  /// 반환: 성공 시 Attendance, 실패 시 AttendanceFailure
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

  /// 내 출석 정보 저장
  /// [attendance] : 저장할 출석 엔티티
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

  /// 요일별 참석자 스트림 반환
  /// [weekKey] : 주차 키
  /// [day] : 요일
  /// 반환: 성공 시 Attendance 리스트 스트림, 실패 시 AttendanceFailure 스트림
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
  /// 반환: 성공 시 (이름, 프로필이미지URL), 실패 시 [AttendanceFailure]
  @override
  Future<Either<AttendanceFailure, (String name, String profileImageUrl)>> getCurrentUserProfile() async {
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
} 