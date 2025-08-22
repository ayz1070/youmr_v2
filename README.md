# YouMR v2

Flutter 기반의 모바일 애플리케이션입니다.

## 환경 설정

### 1. 환경변수 파일 설정

프로젝트 루트에 `.env` 파일을 생성하고 다음 내용을 추가하세요:

```bash
# AdMob 환경변수 설정
# 개발용 키값들 (테스트용)
ADMOB_APPLICATION_ID_DEV=ca-app-pub-3940256099942544~3347511713
ADMOB_BANNER_AD_UNIT_ID_DEV=ca-app-pub-3940256099942544/6300978111
ADMOB_INTERSTITIAL_AD_UNIT_ID_DEV=ca-app-pub-3940256099942544/1033173712
ADMOB_REWARDED_AD_UNIT_ID_DEV=ca-app-pub-3940256099942544/5224354917

# 프로덕션용 키값들 (실제 배포용)
ADMOB_APPLICATION_ID_PROD=ca-app-pub-6067395853079938~1077730566
ADMOB_BANNER_AD_UNIT_ID_PROD=YOUR_BANNER_AD_UNIT_ID
ADMOB_INTERSTITIAL_AD_UNIT_ID_PROD=YOUR_INTERSTITIAL_AD_UNIT_ID
ADMOB_REWARDED_AD_UNIT_ID_PROD=YOUR_REWARDED_AD_UNIT_ID
```

### 2. 실제 키값 설정

- `YOUR_BANNER_AD_UNIT_ID`: 실제 배너 광고 ID로 교체
- `YOUR_INTERSTITIAL_AD_UNIT_ID`: 실제 전면 광고 ID로 교체  
- `YOUR_REWARDED_AD_UNIT_ID`: 실제 보상형 광고 ID로 교체

### 3. Android 빌드 설정

프로젝트는 BuildConfig를 사용하여 환경별 AdMob Application ID를 자동으로 설정합니다:

- **개발 모드**: `ca-app-pub-3940256099942544~3347511713` (테스트용)
- **프로덕션 모드**: `ca-app-pub-6067395853079938~1077730566` (실제 배포용)

#### 키값 변경 방법

1. **테스트용 키값**: `android/gradle.properties`에서 수정 (git에 포함)
2. **프로덕션 키값**: `android/local.properties`에서 수정 (git에서 제외)
3. **프로젝트 클린 후 재빌드**: `cd android && ./gradlew clean`

#### 보안 설정

- `android/gradle.properties`: 개발용 키값 포함 (공유 가능, 테스트용)
- `android/local.properties`: 배포용 키값 포함 (개인용, git에서 제외)
- CI/CD 환경에서는 환경변수로 설정

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
