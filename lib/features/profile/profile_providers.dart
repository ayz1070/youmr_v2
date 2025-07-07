import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data/data_sources/profile_firestore_data_source.dart';
import 'data/repositories/profile_repository_impl.dart';
import 'domain/repositories/profile_repository.dart';
import 'domain/use_cases/fetch_profile_use_case.dart';
import 'domain/use_cases/update_profile_use_case.dart';
import 'presentation/controllers/profile_controller.dart';

/// 프로필 관련 의존성 주입 provider 모음

// 데이터소스 provider
final profileFirestoreDataSourceProvider = Provider<ProfileFirestoreDataSource>((ref) {
  return ProfileFirestoreDataSource();
});

// 리포지토리 provider
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final dataSource = ref.watch(profileFirestoreDataSourceProvider);
  return ProfileRepositoryImpl(dataSource);
});

// 유스케이스 provider
final fetchProfileUseCaseProvider = Provider<FetchProfileUseCase>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return FetchProfileUseCase(repository);
});
final updateProfileUseCaseProvider = Provider<UpdateProfileUseCase>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return UpdateProfileUseCase(repository);
});

// 컨트롤러 provider
final profileControllerProvider = AsyncNotifierProvider<ProfileController, ProfileState>(
  ProfileController.new,
); 