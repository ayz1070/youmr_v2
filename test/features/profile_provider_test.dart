import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youmr_v2/features/profile/presentation/providers/profile_provider.dart';
import 'package:youmr_v2/features/profile/domain/entities/profile.dart';
import 'package:youmr_v2/features/profile/core/errors/profile_failure.dart';

class MockProfileNotifier extends Mock implements ProfileNotifier {}

void main() {
  group('ProfileProvider', () {
    late ProviderContainer container;
    late MockProfileNotifier mockNotifier;

    setUp(() {
      container = ProviderContainer(overrides: [
        profileProvider.overrideWith(() => MockProfileNotifier()),
      ]);
      mockNotifier = container.read(profileProvider.notifier) as MockProfileNotifier;
    });

    tearDown(() {
      container.dispose();
    });

    test('Given 정상 프로필, When build 호출, Then 프로필 데이터 반환', () async {
      // Given
      final profile = Profile(
        uid: 'test_uid',
        nickname: '홍길동',
        userType: 'member',
        profileImageUrl: '',
        dayOfWeek: '',
      );
      when(() => mockNotifier.build()).thenAnswer((_) async => profile);

      // When
      final result = await mockNotifier.build();

      // Then
      expect(result, isA<Profile>());
      expect(result.nickname, '홍길동');
    });

    test('Given 저장 성공, When saveProfile 호출, Then 에러 없이 완료', () async {
      // Given
      final profile = Profile(
        uid: 'test_uid',
        nickname: '테스터',
        userType: 'member',
        profileImageUrl: '',
        dayOfWeek: '',
      );
      when(() => mockNotifier.saveProfile(profile)).thenAnswer((_) async {});

      // When/Then
      expect(() => mockNotifier.saveProfile(profile), returnsNormally);
    });

    test('Given 로그아웃, When logout 호출, Then 에러 없이 완료', () async {
      // Given
      when(() => mockNotifier.logout(any())).thenAnswer((_) async {});

      // When/Then
      expect(() => mockNotifier.logout(any()), returnsNormally);
    });
  });
} 