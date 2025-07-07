import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data/data_sources/auth_firebase_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/use_cases/sign_in_with_google_use_case.dart';
import 'domain/use_cases/save_profile_use_case.dart';
import 'domain/use_cases/check_auth_and_profile_use_case.dart';
import 'presentation/controllers/auth_controller.dart';
import 'domain/entities/user_entity.dart';

/// 인증 관련 의존성 주입 provider 모음

// 데이터소스 provider
final authFirebaseDataSourceProvider = Provider<AuthFirebaseDataSource>((ref) {
  return AuthFirebaseDataSource();
});

// 리포지토리 provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dataSource = ref.watch(authFirebaseDataSourceProvider);
  return AuthRepositoryImpl(dataSource);
});

// 유스케이스 provider
final signInWithGoogleUseCaseProvider = Provider<SignInWithGoogleUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignInWithGoogleUseCase(repository);
});
final saveProfileUseCaseProvider = Provider<SaveProfileUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SaveProfileUseCase(repository);
});
final checkAuthAndProfileUseCaseProvider = Provider<CheckAuthAndProfileUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return CheckAuthAndProfileUseCase(repository);
});

// 컨트롤러 provider
final authControllerProvider = AsyncNotifierProvider<AuthController, UserEntity?>(
  AuthController.new,
); 