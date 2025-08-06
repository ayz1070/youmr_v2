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
  Future<Either<AttendanceFailure, Attendance?>> getMyAttendance({required String weekKey, required String userId}) async {
    try {
      final data = await dataSource.fetchMyAttendance(weekKey: weekKey, userId: userId);
      if (data == null) return const Right(null);
      final dto = AttendanceDto.fromJson(data);
      return Right(dto.toDomain());
    } catch (e, st) {
      // 에러 및 스택트레이스 로깅
      AppLogger.e('출석 정보 조회 실패', error: e, stackTrace: st);
      return Left(AttendanceFirestoreFailure('${ErrorMessages.attendanceLoadError}: $e'));
    }
  }

  /// 내 출석 정보 저장
  /// [attendance] : 저장할 출석 엔티티
  /// 반환: 성공 시 void, 실패 시 AttendanceFailure
  @override
  Future<Either<AttendanceFailure, void>> saveMyAttendance({required Attendance attendance}) async {
    try {
      final dto = AttendanceDto.fromDomain(attendance);
      await dataSource.saveMyAttendance(
        weekKey: dto.weekKey,
        userId: dto.userId,
        data: dto.toJson(),
      );
      return const Right(null);
    } catch (e, st) {
      // 에러 및 스택트레이스 로깅
      AppLogger.e('출석 정보 저장 실패', error: e, stackTrace: st);
      return Left(AttendanceFirestoreFailure('$e'));
    }
  }

  /// 요일별 참석자 스트림 반환
  /// [weekKey] : 주차 키
  /// [day] : 요일
  /// 반환: 성공 시 Attendance 리스트 스트림, 실패 시 AttendanceFailure 스트림
  @override
  Stream<Either<AttendanceFailure, List<Attendance>>> attendeesByDayStream({required String weekKey, required String day}) {
    try {
      return dataSource.attendeesByDayStream(weekKey: weekKey, day: day).map((list) {
        return Right(list.map((e) => AttendanceDto.fromJson(e).toDomain()).toList());
      });
    } catch (e, st) {
      // 에러 및 스택트레이스 로깅
      AppLogger.e('참석자 스트림 실패', error: e, stackTrace: st);
      return Stream.value(Left(AttendanceFirestoreFailure('$e')));
    }
  }

  /// 현재 사용자 프로필 정보 조회
  /// 반환: 성공 시 (이름, 프로필이미지URL), 실패 시 [AttendanceFailure]
  @override
  Future<Either<AttendanceFailure, (String name, String profileImageUrl)>> getCurrentUserProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return Left(AttendanceFirestoreFailure('사용자 정보를 찾을 수 없습니다'));
      }

      // Firestore에서 사용자 정보 가져오기
      final userData = await dataSource.fetchUserData(user.uid);
      if (userData == null) {
        return Left(AttendanceFirestoreFailure('사용자 프로필 정보를 찾을 수 없습니다'));
      }

      // name 필드를 우선 사용하고, 없으면 nickname 사용
      final userName = userData[FirestoreConstants.name] ?? 
                      userData[FirestoreConstants.nickname] ?? 
                      user.displayName ?? 
                      '이름없음';
      final userProfileImageUrl = userData[FirestoreConstants.profileImageUrl] ?? '';

      return Right((userName, userProfileImageUrl));
    } catch (e, st) {
      AppLogger.e('사용자 프로필 정보 조회 실패', error: e, stackTrace: st);
      return Left(AttendanceFirestoreFailure('${ErrorMessages.commonError}: $e'));
    }
  }
} 