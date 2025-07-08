import 'package:dartz/dartz.dart';
import '../../domain/entities/attendance.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../data_sources/attendance_firestore_data_source.dart';
import '../dtos/attendance_dto.dart';
import '../../core/errors/attendance_failure.dart';

/// 출석 Repository 구현체
class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceFirestoreDataSource dataSource;
  AttendanceRepositoryImpl({required this.dataSource});

  @override
  Future<Either<AttendanceFailure, Attendance?>> getMyAttendance({required String weekKey, required String userId}) async {
    try {
      final data = await dataSource.fetchMyAttendance(weekKey: weekKey, userId: userId);
      if (data == null) return const Right(null);
      final dto = AttendanceDto.fromJson(data);
      return Right(dto.toDomain());
    } catch (e) {
      return Left(AttendanceFirestoreFailure('출석 정보 조회 실패: 4e'));
    }
  }

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
    } catch (e) {
      return Left(AttendanceFirestoreFailure('출석 정보 저장 실패: 4e'));
    }
  }

  @override
  Stream<Either<AttendanceFailure, List<Attendance>>> attendeesByDayStream({required String weekKey, required String day}) {
    try {
      return dataSource.attendeesByDayStream(weekKey: weekKey, day: day).map((list) {
        return Right(list.map((e) => AttendanceDto.fromJson(e).toDomain()).toList());
      });
    } catch (e) {
      return Stream.value(Left(AttendanceFirestoreFailure('참석자 스트림 실패: 4e')));
    }
  }
} 