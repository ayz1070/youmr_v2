import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data/data_sources/user_firestore_data_source.dart';
import 'data/repositories/admin_repository_impl.dart';
import 'domain/repositories/admin_repository.dart';
import 'domain/use_cases/fetch_admin_users_use_case.dart';
import 'domain/use_cases/change_user_type_use_case.dart';
import 'domain/use_cases/remove_user_use_case.dart';
import 'presentation/controllers/member_management_controller.dart';

/// 관리자 관련 의존성 주입 provider 모음

// 데이터소스 provider
final userFirestoreDataSourceProvider = Provider<UserFirestoreDataSource>((ref) {
  return UserFirestoreDataSource();
});

// 리포지토리 provider
final adminRepositoryProvider = Provider<AdminRepository>((ref) {
  final dataSource = ref.watch(userFirestoreDataSourceProvider);
  return AdminRepositoryImpl(dataSource);
});

// 유스케이스 provider
final fetchAdminUsersUseCaseProvider = Provider<FetchAdminUsersUseCase>((ref) {
  final repository = ref.watch(adminRepositoryProvider);
  return FetchAdminUsersUseCase(repository);
});
final changeUserTypeUseCaseProvider = Provider<ChangeUserTypeUseCase>((ref) {
  final repository = ref.watch(adminRepositoryProvider);
  return ChangeUserTypeUseCase(repository);
});
final removeUserUseCaseProvider = Provider<RemoveUserUseCase>((ref) {
  final repository = ref.watch(adminRepositoryProvider);
  return RemoveUserUseCase(repository);
});

// 컨트롤러 provider
final memberManagementControllerProvider = AsyncNotifierProvider<MemberManagementController, MemberManagementState>(
  MemberManagementController.new,
); 