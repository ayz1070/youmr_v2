import 'package:dartz/dartz.dart';
import '../entities/auth_user.dart';
import '../../core/errors/auth_failure.dart';

/// 인증 관련 Repository 인터페이스
/// - 인증 도메인 기능을 추상화
abstract class AuthRepository {
  /// 구글 로그인
  /// 반환: 성공 시 [AuthUser], 실패 시 [AuthFailure]
  Future<Either<AuthFailure, AuthUser>> signInWithGoogle();

  /// 로그아웃
  /// 반환: 성공 시 void, 실패 시 [AuthFailure]
  Future<Either<AuthFailure, void>> signOut();

  /// 현재 로그인 유저 반환
  /// 반환: 성공 시 [AuthUser?], 실패 시 [AuthFailure]
  Future<Either<AuthFailure, AuthUser?>> getCurrentUser();

  /// Firestore에 프로필 저장
  /// [user]: 저장할 유저 정보
  /// 반환: 성공 시 void, 실패 시 [AuthFailure]
  Future<Either<AuthFailure, void>> saveProfile({required AuthUser user});
} 