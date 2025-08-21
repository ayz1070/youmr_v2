import 'package:dartz/dartz.dart';
import 'package:youmr_v2/core/constants/app_logger.dart';
import 'package:youmr_v2/core/errors/app_failure.dart';
import '../../domain/entities/admin_user.dart';
import '../../domain/repositories/admin_user_repository.dart';
import '../data_sources/admin_user_firestore_data_source.dart';
import '../dtos/admin_user_dto.dart';

/// 관리자/회원 Repository 구현체
///
/// - DataSource/DTO만 의존
/// - 도메인 엔티티 변환, 함수형 에러 처리, 로깅, DI 구조
/// - 모든 필드/생성자/함수/파라미터/반환값에 한글 주석 필수
class AdminUserRepositoryImpl implements AdminUserRepository {
  /// Firestore 데이터소스
  final AdminUserFirestoreDataSource dataSource;
  /// 생성자
  /// [dataSource] : 외부에서 주입(DI, 테스트 용이)
  AdminUserRepositoryImpl({required this.dataSource});

  /// 전체 회원 목록 조회
  /// return: Either<AppFailure, List<AdminUser>>
  @override
  Future<Either<AppFailure, List<AdminUser>>> getAllUsers() async {
    try {
      final List<Map<String, dynamic>> list = await dataSource.fetchAllUsers();
      final List<AdminUser> users = list.map((e) {
        try {
          return AdminUserDto.fromJson(e).toDomain();
        } catch (parseError) {
          AppLogger.e('사용자 데이터 파싱 실패: $parseError', error: parseError);
          // 파싱 실패한 데이터는 건너뛰기
          return null;
        }
      }).where((user) => user != null).cast<AdminUser>().toList();
      
      return Right(users);
    } catch (e, st) {
      AppLogger.e('getAllUsers 실패', error: e, stackTrace: st);
      return Left(AppFailure('회원 목록 조회에 실패했습니다.'));
    }
  }

  /// 회원 권한 변경
  /// [uid] : 회원 UID
  /// [newType] : 변경할 권한 타입
  /// return: Either<AppFailure, void>
  @override
  Future<Either<AppFailure, void>> changeUserType({required String uid, required String newType}) async {
    try {
      await dataSource.updateUserType(uid: uid, newType: newType);
      return const Right(null);
    } catch (e, st) {
      AppLogger.e('changeUserType 실패', error: e, stackTrace: st);
      return Left(AppFailure('회원 권한 변경에 실패했습니다.'));
    }
  }

  /// 회원 삭제
  /// [uid] : 회원 UID
  /// return: Either<AppFailure, void>
  @override
  Future<Either<AppFailure, void>> removeUser({required String uid}) async {
    try {
      await dataSource.deleteUser(uid: uid);
      return const Right(null);
    } catch (e, st) {
      AppLogger.e('removeUser 실패', error: e, stackTrace: st);
      return Left(AppFailure('회원 삭제에 실패했습니다.'));
    }
  }
} 