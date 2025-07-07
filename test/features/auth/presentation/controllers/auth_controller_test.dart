import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youmr_v2/features/auth/presentation/controllers/auth_controller.dart';
import 'package:youmr_v2/features/auth/domain/use_cases/sign_in_with_google_use_case.dart';
import 'package:youmr_v2/features/auth/domain/use_cases/check_auth_and_profile_use_case.dart';
import 'package:youmr_v2/features/auth/domain/entities/user_entity.dart';

class MockSignInWithGoogleUseCase extends Mock implements SignInWithGoogleUseCase {}
class MockCheckAuthAndProfileUseCase extends Mock implements CheckAuthAndProfileUseCase {}

void main() {
  group('AuthController', () {
    late AuthController controller;
    late MockSignInWithGoogleUseCase signInWithGoogleUseCase;
    late MockCheckAuthAndProfileUseCase checkAuthAndProfileUseCase;

    setUp(() {
      signInWithGoogleUseCase = MockSignInWithGoogleUseCase();
      checkAuthAndProfileUseCase = MockCheckAuthAndProfileUseCase();
      controller = AuthController()
        .._signInWithGoogleUseCase = signInWithGoogleUseCase
        .._checkAuthAndProfileUseCase = checkAuthAndProfileUseCase;
    });

    test('Given signInWithGoogle 성공 When signInWithGoogle 호출 Then 상태가 user로 변경', () async {
      // Given
      final user = UserEntity(id: '1', email: 'e', nickname: 'n', profileUrl: '', createdAt: DateTime.now());
      when(() => signInWithGoogleUseCase()).thenAnswer((_) async => user);
      // When
      await controller.signInWithGoogle();
      // Then
      expect(controller.debugState.valueOrNull?.user, user);
    });
  });
} 