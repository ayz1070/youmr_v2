# admin feature 디렉토리 구조 및 규칙

본 디렉토리는 관리자(Admin) 관련 기능을 클린 아키텍처에 따라 data/domain/presentation 계층으로 분리하여 관리합니다.

## 구조 예시
```
features/admin/
├── data/                # 데이터 계층 (데이터소스, DTO, repository 구현)
│   ├── data_sources/    # Firestore 등 외부 데이터소스
│   ├── repositories/    # repository 구현체
├── domain/              # 도메인 계층 (entity, repository, usecase)
│   ├── entities/        # AdminUserEntity 등 엔티티
│   ├── repositories/    # 추상 repository
│   ├── use_cases/       # 유스케이스
├── presentation/        # 프리젠테이션 계층 (controller, page, widget)
│   ├── controllers/     # riverpod 기반 controller
│   ├── pages/           # UI 페이지
│   ├── widgets/         # 공통 위젯
```

## 규칙
- 모든 코드/주석/문서는 한글로 작성
- 각 계층별 역할을 명확히 분리 (SOLID, Clean Architecture)
- riverpod provider는 controller에서 정의, core/di에서 통합 관리
- 테스트는 Given-When-Then, mocktail/mockito, 한글 주석 사용
- 공통 위젯/유틸/에러/네트워크 등은 core 계층 활용
- Freezed, JsonSerializable, 공식 riverpod 어노테이션 적극 활용

## 예시
- AdminUserEntity: 관리자 유저 도메인 모델 (freezed)
- AdminRepository: 관리자 추상 저장소 (interface)
- AdminRepositoryImpl: Firestore 등 실제 구현체
- FetchAdminUsersUseCase: 관리자 유저 목록 조회 유스케이스
- MemberManagementController: riverpod AsyncNotifier 기반 상태/로직 관리
- MemberManagementPage: 회원관리 UI
- AdminUserListTile: 회원관리 공통 위젯 