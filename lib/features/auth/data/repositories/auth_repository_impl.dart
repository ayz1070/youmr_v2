import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_firebase_data_source.dart';
import '../../core/errors/auth_failure.dart';

/// 인증 Repository 구현체
class AuthRepositoryImpl implements AuthRepository {
  final AuthFirebaseDataSource dataSource;
  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<Either<AuthFailure, AuthUser>> signInWithGoogle() async {
    try {
      // 구글 로그인 계정 선택
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return Left(AuthFirebaseFailure('사용자가 로그인 취소'));
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await dataSource.signInWithGoogle(credential: credential);
      final user = userCredential.user;
      if (user == null) return Left(AuthFirebaseFailure('로그인 실패'));
      // Firestore에 유저 정보 저장(최초 로그인 시)
      final userDoc = await dataSource.fetchUserProfile(uid: user.uid);
      if (userDoc == null) {
        await dataSource.saveUserProfile(uid: user.uid, data: {
          'uid': user.uid,
          'email': user.email,
          'nickname': user.displayName ?? '',
          'profileImageUrl': user.photoURL ?? '',
          'userType': '',
          'dayOfWeek': '',
          'fcmToken': '',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      return Right(AuthUser(
        uid: user.uid,
        email: user.email ?? '',
        nickname: user.displayName ?? '',
        profileImageUrl: user.photoURL,
      ));
    } catch (e) {
      return Left(AuthFirebaseFailure('구글 로그인 실패: $e'));
    }
  }

  @override
  Future<Either<AuthFailure, void>> signOut() async {
    try {
      await dataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(AuthFirebaseFailure('로그아웃 실패: $e'));
    }
  }

  @override
  Future<Either<AuthFailure, AuthUser?>> getCurrentUser() async {
    try {
      final user = dataSource.getCurrentUser();
      if (user == null) return const Right(null);
      return Right(AuthUser(
        uid: user.uid,
        email: user.email ?? '',
        nickname: user.displayName ?? '',
        profileImageUrl: user.photoURL,
      ));
    } catch (e) {
      return Left(AuthFirebaseFailure('유저 조회 실패: $e'));
    }
  }

  @override
  Future<Either<AuthFailure, void>> saveProfile({required AuthUser user}) async {
    try {
      await dataSource.saveUserProfile(uid: user.uid, data: user.toJson());
      return const Right(null);
    } catch (e) {
      return Left(AuthFirestoreFailure('프로필 저장 실패: $e'));
    }
  }
} 