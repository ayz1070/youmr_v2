import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youmr_v2/features/profile/presentation/controllers/profile_controller.dart';
import 'package:youmr_v2/features/profile/domain/use_cases/fetch_profile_use_case.dart';
import 'package:youmr_v2/features/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:youmr_v2/features/profile/domain/entities/profile_entity.dart';

class MockFetchProfileUseCase extends Mock implements FetchProfileUseCase {}
class MockUpdateProfileUseCase extends Mock implements UpdateProfileUseCase {}

void main() {
  group('ProfileController', () {
    late ProfileController controller;
    late MockFetchProfileUseCase fetchProfileUseCase;
    late MockUpdateProfileUseCase updateProfileUseCase;

    setUp(() {
      fetchProfileUseCase = MockFetchProfileUseCase();
      updateProfileUseCase = MockUpdateProfileUseCase();
      controller = ProfileController()
        .._fetchProfileUseCase = fetchProfileUseCase
        .._updateProfileUseCase = updateProfileUseCase;
    });

    test('Given fetchProfile 성공 When fetchProfile 호출 Then 상태가 profile로 변경', () async {
      // Given
      final profile = ProfileEntity(id: '1', email: 'e', nickname: 'n', userType: 'member', profileImageUrl: '', createdAt: DateTime.now());
      when(() => fetchProfileUseCase()).thenAnswer((_) async => profile);
      // When
      await controller.fetchProfile();
      // Then
      expect(controller.debugState.valueOrNull?.profile, profile);
    });
  });
} 