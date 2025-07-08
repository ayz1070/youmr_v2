# 프로필(Profile) Feature

## 아키텍처
- Clean Architecture (data/domain/presentation/core 계층 분리)
- Riverpod 상태관리(AsyncNotifierProvider)
- Freezed, JsonSerializable, SOLID, 타입 명시, 한글 주석

## 폴더 구조
```
lib/features/profile/
  core/errors/profile_failure.dart
  data/data_sources/profile_firestore_data_source.dart
  data/dtos/profile_dto.dart
  data/repositories/profile_repository_impl.dart
  domain/entities/profile.dart
  domain/value_objects/user_type.dart
  domain/repositories/profile_repository.dart
  domain/use_cases/get_my_profile.dart
  domain/use_cases/save_my_profile.dart
  presentation/providers/profile_provider.dart
  presentation/pages/profile_page.dart
  presentation/pages/profile_edit_page.dart
```

## 상태관리
- Provider만 구독, UI에서 직접 DB 접근/로직 없음
- 프로필 불러오기/저장/로그아웃 모두 Provider에서 처리

## 테스트
- mocktail, Given-When-Then, 한글 주석 필수
- test/features/profile_provider_test.dart 참고

## 개발 규칙
- 모든 코드/주석/문서 한글
- SOLID, 타입 안전, 엔터프라이즈 패턴
- 불필요한 import/변수/함수 금지
- Freezed, JsonSerializable, Riverpod, mocktail 필수

## 예시
```dart
final profileAsync = ref.watch(profileProvider);
final notifier = ref.read(profileProvider.notifier);
```

## 기타
- 기능 확장/유지보수/테스트 용이성을 최우선으로 설계 