import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youmr_v2/features/admin/presentation/controllers/member_management_controller.dart';
import 'package:youmr_v2/features/admin/domain/use_cases/fetch_admin_users_use_case.dart';
import 'package:youmr_v2/features/admin/domain/use_cases/change_user_type_use_case.dart';
import 'package:youmr_v2/features/admin/domain/use_cases/remove_user_use_case.dart';
import 'package:youmr_v2/features/admin/domain/entities/admin_user_entity.dart';

class MockFetchAdminUsersUseCase extends Mock implements FetchAdminUsersUseCase {}
class MockChangeUserTypeUseCase extends Mock implements ChangeUserTypeUseCase {}
class MockRemoveUserUseCase extends Mock implements RemoveUserUseCase {}

void main() {
  group('MemberManagementController', () {
    late MemberManagementController controller;
    late MockFetchAdminUsersUseCase fetchUsersUseCase;
    late MockChangeUserTypeUseCase changeUserTypeUseCase;
    late MockRemoveUserUseCase removeUserUseCase;

    setUp(() {
      fetchUsersUseCase = MockFetchAdminUsersUseCase();
      changeUserTypeUseCase = MockChangeUserTypeUseCase();
      removeUserUseCase = MockRemoveUserUseCase();
      controller = MemberManagementController()
        .._fetchUsersUseCase = fetchUsersUseCase
        .._changeUserTypeUseCase = changeUserTypeUseCase
        .._removeUserUseCase = removeUserUseCase;
    });

    test('Given fetchUsers 성공 When fetchUsers 호출 Then 상태가 users로 변경', () async {
      // Given
      final users = [AdminUserEntity(id: '1', email: 'e', nickname: 'n', userType: 'admin', profileImageUrl: '', createdAt: DateTime.now())];
      when(() => fetchUsersUseCase()).thenAnswer((_) async => users);
      // When
      await controller.fetchUsers();
      // Then
      expect(controller.debugState.valueOrNull?.users, users);
    });
  });
} 