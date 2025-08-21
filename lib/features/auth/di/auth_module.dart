import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../notification/presentation/providers/notification_provider.dart';
import '../data/data_sources/auth_data_source.dart';
import '../data/data_sources/auth_firebase_data_source.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/entities/auth_user.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/use_cases/sign_in_with_google.dart';
import '../domain/use_cases/sign_out.dart';
import '../domain/use_cases/get_current_user.dart';
import '../domain/use_cases/save_profile.dart';
import '../domain/use_cases/upload_profile_image.dart';
import '../domain/use_cases/delete_profile_image.dart';
import '../presentation/providers/notifier/auth_notifier.dart';

/// ===== DataSource Providers =====

/// Firebase Auth 인스턴스 Provider
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

/// Firestore 인스턴스 Provider
final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

/// Firebase Storage 인스턴스 Provider
final firebaseStorageProvider = Provider<FirebaseStorage>((ref) {
  return FirebaseStorage.instance;
});

/// GoogleSignIn 인스턴스 Provider
final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn();
});

/// AuthFirebaseDataSource Provider
final authFirebaseDataSourceProvider = Provider<AuthFirebaseDataSource>((ref) {
  return AuthFirebaseDataSource(
    auth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firestoreProvider),
    storage: ref.watch(firebaseStorageProvider),
  );
});

/// ===== Repository Providers =====

/// AuthRepository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    dataSource: ref.watch(authFirebaseDataSourceProvider),
    googleSignIn: ref.watch(googleSignInProvider),
  );
});

/// ===== UseCase Providers =====

/// 구글 로그인 UseCase Provider
final signInWithGoogleUseCaseProvider = Provider<SignInWithGoogle>((ref) {
  return SignInWithGoogle(repository: ref.watch(authRepositoryProvider));
});

/// 로그아웃 UseCase Provider
final signOutUseCaseProvider = Provider<SignOut>((ref) {
  return SignOut(repository: ref.watch(authRepositoryProvider));
});

/// 현재 사용자 조회 UseCase Provider
final getCurrentUserUseCaseProvider = Provider<GetCurrentUser>((ref) {
  return GetCurrentUser(repository: ref.watch(authRepositoryProvider));
});

/// 프로필 저장 UseCase Provider
final saveProfileUseCaseProvider = Provider<SaveProfile>((ref) {
  return SaveProfile(repository: ref.watch(authRepositoryProvider));
});

/// 프로필 이미지 업로드 UseCase Provider
final uploadProfileImageUseCaseProvider = Provider<UploadProfileImage>((ref) {
  return UploadProfileImage(repository: ref.watch(authRepositoryProvider));
});

/// 프로필 이미지 삭제 UseCase Provider
final deleteProfileImageUseCaseProvider = Provider<DeleteProfileImage>((ref) {
  return DeleteProfileImage(repository: ref.watch(authRepositoryProvider));
});

/// 인증 상태 관리 Provider
/// - UseCase들을 외부에서 의존성 주입받아 AuthNotifier 생성
final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<AuthUser?>>((ref) {
  return AuthNotifier(
    signInWithGoogle: ref.watch(signInWithGoogleUseCaseProvider),
    signOut: ref.watch(signOutUseCaseProvider),
    getCurrentUser: ref.watch(getCurrentUserUseCaseProvider),
    saveProfile: ref.watch(saveProfileUseCaseProvider),
    uploadProfileImage: ref.watch(uploadProfileImageUseCaseProvider),
    deleteProfileImage: ref.watch(deleteProfileImageUseCaseProvider),
    notificationProvider: ref.watch(notificationProvider.notifier),
  );
});



/// ===== Mock/Test용 Providers =====

/// 테스트용 Mock DataSource Provider (ProviderScope override로 사용)
final mockAuthDataSourceProvider = Provider<AuthDataSource>((ref) {
  // 테스트 시 MockDataSource 반환
  throw UnimplementedError('테스트 시 ProviderScope override로 MockDataSource 주입 필요');
});

/// 테스트용 Mock Repository Provider (ProviderScope override로 사용)
final mockAuthRepositoryProvider = Provider<AuthRepository>((ref) {
  // 테스트 시 MockRepository 주입 필요
  throw UnimplementedError('테스트 시 ProviderScope override로 MockRepository 주입 필요');
});
