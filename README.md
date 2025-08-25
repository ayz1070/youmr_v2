# YouMR 📱

> Flutter 기반의 기타 동호회 여민락의 오프라인 모임과 온라인 콘텐츠를 연결하는 커뮤니티 플랫폼

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

## 📋 프로젝트 개요

YouMR 은 Clean Architecture와 기타 동호회 여민락의 오프라인 모임과 온라인 콘텐츠를 연결하는 커뮤니티 서비스입니다. 사용자들이 게시물 및 연주 영상, 강의 영상을 공유하고, 투표에 참여하며, 출석 체크를 통해 온, 오프라인 커뮤니티 활동을 할 수 있는 플랫폼을 제공합니다.

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
- 텍스트, 동영상 게시물 작성
- YouTube 동영상 임베딩
- 댓글 시스템
- 게시물 좋아요 기능

### 📊 출석 체크
- 오프라인 회원의 연습실 출석 인원 파악

### 🗳️ 신청곡 투표 시스템
- 회원들이 원하는 곡을 등록하고 투표를 통해 선택함
- 선택된 곡을 기반으로 영상 제작

### 🔔 알림 시스템
- Firebase Cloud Messaging (FCM) 기반 푸시 알림
- 회비 및 출석 체크에 대한 스케줄링된 알림 발송

### 👨‍💼 관리자 기능
- 사용자 관리
- 공지 등록
- 커스텀 메시징 전달

### 💰 광고 시스템
- Google AdMob 통합
- 배너 광고 도입

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

### Third-party Integrations
- **Video**: YouTube Player
- **Ads**: Google AdMob
- **Social Login**: Google Sign-In
- **Local Storage**: SharedPreferences

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

## 🚧 향후 개발 계획

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


## 📞Contact

- **이메일**: ayz1070@gmail.com

---

