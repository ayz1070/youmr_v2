# YouMR v2 📱

> Flutter 기반의 소셜 미디어 모바일 애플리케이션

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

## 📋 프로젝트 개요

YouMR v2는 Clean Architecture와 현대적인 Flutter 개발 패턴을 적용한 소셜 미디어 모바일 애플리케이션입니다. 사용자들이 게시물을 공유하고, 투표에 참여하며, 출석 체크를 통해 커뮤니티 활동을 할 수 있는 플랫폼을 제공합니다.

### 🎯 주요 특징
- **Clean Architecture** 적용으로 유지보수성과 확장성 확보
- **다중 환경 지원** (Development/Test/Production)
- **실시간 데이터 동기화** Firebase 기반
- **반응형 상태관리** Riverpod 적용
- **모바일 최적화** Android/iOS 네이티브 성능

## 🚀 주요 기능

### 👤 사용자 인증
- Google 소셜 로그인
- Firebase Authentication 기반 보안 인증
- 자동 로그인 및 세션 관리

### 📝 게시물 시스템
- 텍스트, 이미지, 동영상 게시물 작성
- YouTube 동영상 임베딩
- 실시간 댓글 시스템
- 게시물 좋아요/공유 기능

### 🗳️ 투표 시스템
- 다중 선택 투표 생성/참여
- 실시간 투표 결과 확인
- 투표 참여 이력 관리

### 📊 출석 체크
- 일일 출석 체크 기능
- 출석률 통계 및 분석
- 출석 보상 시스템

### 🔔 알림 시스템
- Firebase Cloud Messaging (FCM) 기반 푸시 알림
- 로컬 알림 스케줄링
- 알림 내역 관리

### 👨‍💼 관리자 기능
- 사용자 관리
- 게시물 관리
- 시스템 모니터링

### 💰 광고 시스템
- Google AdMob 통합
- 배너, 전면, 보상형 광고
- 환경별 광고 설정

## 🏗️ 기술 스택

### Frontend
- **Framework**: Flutter 3.8.0+
- **Language**: Dart
- **State Management**: Riverpod
- **UI/UX**: Material Design, Google Fonts
- **Navigation**: GoRouter

### Backend & Services
- **Authentication**: Firebase Auth
- **Database**: Cloud Firestore
- **Storage**: Firebase Storage
- **Push Notification**: Firebase Cloud Messaging
- **Functions**: Firebase Functions (Node.js)

### Architecture & Patterns
- **Architecture**: Clean Architecture
- **Design Patterns**: Repository Pattern, Provider Pattern
- **Code Generation**: Freezed, JsonSerializable, Riverpod Generator
- **Testing**: Unit/Widget/Integration Testing with Mocktail

### Third-party Integrations
- **Maps**: Naver Map SDK
- **Video**: YouTube Player
- **Ads**: Google AdMob
- **Social Login**: Google Sign-In
- **Local Storage**: Hive, SharedPreferences

## 📁 프로젝트 구조

```
lib/
├── core/                          # 공통 모듈
│   ├── config/                    # 환경 설정
│   ├── constants/                 # 상수 정의
│   ├── errors/                    # 에러 처리
│   ├── services/                  # 공통 서비스
│   ├── theme/                     # 앱 테마
│   ├── utils/                     # 유틸리티
│   └── widgets/                   # 공통 위젯
├── features/                      # 기능별 모듈
│   ├── auth/                      # 인증
│   ├── post/                      # 게시물
│   ├── voting/                    # 투표
│   ├── attendance/                # 출석
│   ├── profile/                   # 프로필
│   ├── notification/              # 알림
│   ├── admin/                     # 관리자
│   └── policy/                    # 정책
└── main.dart                      # 앱 진입점
```

### Feature 모듈 구조 (Clean Architecture)
```
features/{feature_name}/
├── data/
│   ├── data_sources/              # 데이터 소스 (API, Local)
│   ├── dtos/                      # 데이터 전송 객체
│   └── repositories/              # Repository 구현체
├── domain/
│   ├── entities/                  # 도메인 엔티티
│   ├── repositories/              # Repository 인터페이스
│   ├── use_cases/                 # 비즈니스 로직
│   └── value_objects/             # 값 객체
├── presentation/
│   ├── pages/                     # UI 페이지
│   ├── widgets/                   # 컴포넌트
│   └── providers/                 # 상태 관리
└── di/
    └── {feature_name}_module.dart # 의존성 주입
```

## 🔧 개발 환경 설정

### 1. 사전 요구사항
- Flutter SDK 3.8.0+
- Dart SDK 3.0.0+
- Android Studio / VS Code
- iOS 개발시 Xcode (macOS)

### 2. 프로젝트 설정

```bash
# 레포지토리 클론
git clone <repository-url>
cd youmr_v2

# 의존성 설치
flutter pub get

# 코드 생성
dart run build_runner build
```

### 3. 환경변수 설정

프로젝트 루트에 `.env` 파일을 생성:

```bash
# AdMob 환경변수 설정
# 개발용 키값들 (테스트용)
ADMOB_APPLICATION_ID_DEV=ca-app-pub-3940256099942544~3347511713
ADMOB_BANNER_AD_UNIT_ID_DEV=ca-app-pub-3940256099942544/6300978111
ADMOB_INTERSTITIAL_AD_UNIT_ID_DEV=ca-app-pub-3940256099942544/1033173712
ADMOB_REWARDED_AD_UNIT_ID_DEV=ca-app-pub-3940256099942544/5224354917

# 프로덕션용 키값들 (실제 배포용)
ADMOB_APPLICATION_ID_PROD=YOUR_ACTUAL_APPLICATION_ID
ADMOB_BANNER_AD_UNIT_ID_PROD=YOUR_BANNER_AD_UNIT_ID
ADMOB_INTERSTITIAL_AD_UNIT_ID_PROD=YOUR_INTERSTITIAL_AD_UNIT_ID
ADMOB_REWARDED_AD_UNIT_ID_PROD=YOUR_REWARDED_AD_UNIT_ID
```

### 4. Firebase 설정
1. Firebase Console에서 프로젝트 생성
2. Android/iOS 앱 추가
3. `google-services.json` (Android) 및 `GoogleService-Info.plist` (iOS) 다운로드
4. 각 환경별 Firebase 설정 파일 배치

### 5. 실행

```bash
# 개발 환경 실행
./scripts/run_dev.sh

# 테스트 환경 실행
./scripts/run_test.sh

# 프로덕션 환경 실행
./scripts/run_prod.sh
```

## 🚀 배포

### Android
```bash
# APK 빌드
flutter build apk --release

# AAB 빌드 (Google Play Store)
flutter build appbundle --release
```

### iOS
```bash
# iOS 빌드
flutter build ios --release
```

## 🧪 테스트

```bash
# 단위 테스트 실행
flutter test

# 통합 테스트 실행
flutter test integration_test/

# 코드 커버리지 확인
flutter test --coverage
```

## 📊 아키텍처 특징

### Clean Architecture 적용
- **Domain Layer**: 비즈니스 로직과 엔티티
- **Data Layer**: 데이터 소스와 Repository 구현
- **Presentation Layer**: UI와 상태 관리

### 의존성 역전 원칙
- 인터페이스 기반 설계
- 테스트 가능한 구조
- 모듈 간 결합도 최소화

### 반응형 상태 관리
- Riverpod을 통한 선언적 상태 관리
- 비동기 데이터 처리 최적화
- 메모리 효율적 상태 업데이트

## 🔐 보안

### 데이터 보안
- Firebase Security Rules 적용
- 환경변수를 통한 API 키 관리
- 사용자 권한 기반 데이터 접근 제어

### 코드 보안
- API 키 하드코딩 방지
- ProGuard/R8을 통한 코드 난독화
- 민감 정보 로컬 저장 시 암호화

## 📈 성능 최적화

### 이미지 최적화
- 이미지 압축 및 리사이징
- 캐시를 통한 네트워크 요청 최소화
- 지연 로딩 구현

### 메모리 관리
- 위젯 생명주기 최적화
- 불필요한 리빌드 방지
- 메모리 누수 방지

### 네트워크 최적화
- Firebase Offline Persistence
- 배치 처리를 통한 API 호출 최적화
- 실시간 리스너 효율적 관리

## 🚧 향후 개발 계획

- [ ] 다크 모드 지원
- [ ] 다국어 지원 (i18n)
- [ ] 웹 플랫폼 지원
- [ ] AI 기반 콘텐츠 추천
- [ ] 실시간 채팅 기능
- [ ] 데이터 분석 대시보드

## 📝 개발 경험 및 학습 성과

### 기술적 성장
- **Clean Architecture** 적용을 통한 대규모 앱 설계 경험
- **Firebase 생태계** 전체 스택 활용 능력 획득
- **다중 환경 구성** 및 배포 자동화 경험
- **상태 관리** 패턴의 깊이 있는 이해

### 프로젝트 관리
- Feature 기반 모듈화를 통한 팀 개발 효율성 향상
- Git Flow를 활용한 체계적인 버전 관리
- 지속적 통합/배포(CI/CD) 파이프라인 구축

### 사용자 경험
- 모바일 네이티브 성능 최적화
- 접근성을 고려한 UI/UX 설계
- 실시간 데이터 동기화를 통한 반응성 향상

## 👥 기여

프로젝트에 기여를 원하신다면:

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📄 라이선스

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 연락처

- **개발자**: YouMR 개발팀
- **위치**: 서울 도봉구 도당로29길 66
- **이메일**: [연락처 추가 필요]

---

**Made with ❤️ using Flutter**