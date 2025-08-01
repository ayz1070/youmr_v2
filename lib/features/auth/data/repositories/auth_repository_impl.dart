import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:youmr_v2/core/constants/firestore_constants.dart';
import 'package:youmr_v2/core/constants/error_messages.dart';
import 'package:youmr_v2/core/constants/app_logger.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_firebase_data_source.dart';
import '../../core/errors/auth_failure.dart';

/// 인증 Repository 구현체
/// - DataSource/DTO만 의존
/// - 도메인 엔티티 변환, 예외를 Failure로 변환, 로깅 담당
class AuthRepositoryImpl implements AuthRepository {
  /// 인증 관련 데이터 소스
  final AuthFirebaseDataSource dataSource;
  /// GoogleSignIn 외부 의존성(DI)
  final GoogleSignIn googleSignIn;

  /// [dataSource], [googleSignIn]은 DI로 주입(테스트 용이성)
  const AuthRepositoryImpl({required this.dataSource, required this.googleSignIn});

  /// 구글 로그인
  /// 성공: [AuthUser] 반환, 실패: [AuthFailure] 반환
  @override
  Future<Either<AuthFailure, AuthUser>> signInWithGoogle() async {
    try {
      // 구글 로그인 계정 선택
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return const Left(AuthFirebaseFailure(ErrorMessages.commonError));
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await dataSource.signInWithGoogle(credential: credential);
      final User? user = userCredential.user;
      if (user == null) {
        return const Left(AuthFirebaseFailure(ErrorMessages.commonError));
      }
      // Firestore에 유저 정보 저장(최초 로그인 시)
      final Map<String, dynamic>? userDoc = await dataSource.fetchUserProfile(uid: user.uid);
      if (userDoc == null) {
        await dataSource.saveUserProfile(uid: user.uid, data: {
          FirestoreConstants.userId: user.uid,
          'email': user.email,
          FirestoreConstants.nickname: user.displayName ?? '',
          FirestoreConstants.profileImageUrl: user.photoURL ?? '',
          'userType': '',
          'dayOfWeek': '',
          'fcmToken': '',
          FirestoreConstants.lastUpdated: FieldValue.serverTimestamp(),
        });
      }
      return Right(AuthUser(
        uid: user.uid,
        email: user.email ?? '',
        nickname: user.displayName ?? '',
        profileImageUrl: user.photoURL,
      ));
    } catch (e, st) {
      AppLogger.e('구글 로그인 실패', error: e, stackTrace: st);
      return Left(AuthFirebaseFailure('${ErrorMessages.commonError}: $e'));
    }
  }

  /// 로그아웃
  /// 성공: void, 실패: [AuthFailure]
  @override
  Future<Either<AuthFailure, void>> signOut() async {
    try {
      await dataSource.signOut();
      return const Right(null);
    } catch (e, st) {
      AppLogger.e('로그아웃 실패', error: e, stackTrace: st);
      return Left(AuthFirebaseFailure('${ErrorMessages.commonError}: $e'));
    }
  }

  /// 현재 로그인 유저 조회
  /// 성공: [AuthUser], 실패: [AuthFailure]
  @override
  Future<Either<AuthFailure, AuthUser?>> getCurrentUser() async {
    try {
      final User? user = dataSource.getCurrentUser();
      if (user == null) return const Right(null);
      return Right(AuthUser(
        uid: user.uid,
        email: user.email ?? '',
        nickname: user.displayName ?? '',
        profileImageUrl: user.photoURL,
      ));
    } catch (e, st) {
      AppLogger.e('유저 조회 실패', error: e, stackTrace: st);
      return Left(AuthFirebaseFailure('${ErrorMessages.commonError}: $e'));
    }
  }

  /// 프로필 저장
  /// 성공: void, 실패: [AuthFailure]
  @override
  Future<Either<AuthFailure, void>> saveProfile({required AuthUser user}) async {
    try {
      await dataSource.saveUserProfile(uid: user.uid, data: user.toJson());
      return const Right(null);
    } catch (e, st) {
      AppLogger.e('프로필 저장 실패', error: e, stackTrace: st);
      return Left(AuthFirestoreFailure('${ErrorMessages.commonError}: $e'));
    }
  }

  /// 프로필 이미지 업로드
  /// 성공: 이미지 URL, 실패: [AuthFailure]
  @override
  Future<Either<AuthFailure, String>> uploadProfileImage({
    required String uid,
    required File imageFile,
  }) async {
    try {
      final String imageUrl = await dataSource.uploadProfileImage(uid: uid, imageFile: imageFile);
      return Right(imageUrl);
    } catch (e, st) {
      AppLogger.e('프로필 이미지 업로드 실패', error: e, stackTrace: st);
      return Left(AuthFirebaseFailure('프로필 이미지 업로드 실패: $e'));
    }
  }

  /// 프로필 이미지 삭제
  /// 성공: void, 실패: [AuthFailure]
  @override
  Future<Either<AuthFailure, void>> deleteProfileImage({required String imageUrl}) async {
    try {
      await dataSource.deleteProfileImage(imageUrl: imageUrl);
      return const Right(null);
    } catch (e, st) {
      AppLogger.e('프로필 이미지 삭제 실패', error: e, stackTrace: st);
      return Left(AuthFirebaseFailure('프로필 이미지 삭제 실패: $e'));
    }
  }

  /// 유저의 모든 프로필 이미지 삭제
  /// 성공: void, 실패: [AuthFailure]
  @override
  Future<Either<AuthFailure, void>> deleteAllProfileImages({required String uid}) async {
    try {
      await dataSource.deleteAllProfileImages(uid: uid);
      return const Right(null);
    } catch (e, st) {
      AppLogger.e('프로필 이미지 전체 삭제 실패', error: e, stackTrace: st);
      return Left(AuthFirebaseFailure('프로필 이미지 전체 삭제 실패: $e'));
    }
  }
} 