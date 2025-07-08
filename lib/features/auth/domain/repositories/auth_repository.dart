import 'package:dartz/dartz.dart';
import '../entities/auth_user.dart';
import '../../core/errors/auth_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// 인증 관련 Repository 인터페이스
abstract class AuthRepository {
  /// 구글 로그인
  Future<Either<AuthFailure, AuthUser>> signInWithGoogle();

  /// 로그아웃
  Future<Either<AuthFailure, void>> signOut();

  /// 현재 로그인 유저 반환
  Future<Either<AuthFailure, AuthUser?>> getCurrentUser();

  /// Firestore에 프로필 저장
  Future<Either<AuthFailure, void>> saveProfile({required AuthUser user});
} 