# Firebase 환경별 설정 가이드

## 개요

이 프로젝트는 Firebase를 사용하여 개발, 테스트, 프로덕션 환경을 분리하여 관리합니다.

## 환경별 Firebase 프로젝트

| 환경 | 프로젝트 ID | 설명 |
|------|-------------|------|
| **프로덕션** | `youmr-v2` | 실제 서비스 환경 |
| **테스트** | `youmr-test` | 테스트 환경 (아직 미설정) |
| **개발** | `youmr-dev` | 개발 환경 |

## 실행 방법

### 1. 스크립트 사용 (권장)

```bash
# 개발 환경
./scripts/run_dev.sh

# 테스트 환경
./scripts/run_test.sh

# 프로덕션 환경
./scripts/run_prod.sh
```

### 2. 직접 명령어 실행

```bash
# 개발 환경
flutter run --dart-define=ENVIRONMENT=development

# 테스트 환경
flutter run --dart-define=ENVIRONMENT=test

# 프로덕션 환경
flutter run --dart-define=ENVIRONMENT=production
```

## 환경별 설정 파일

- `lib/firebase_options.dart` - 프로덕션 환경
- `lib/firebase_options_dev.dart` - 개발 환경
- `lib/firebase_options_test.dart` - 테스트 환경 (기본값은 프로덕션)

## 테스트 환경 설정 완료 방법

테스트 환경을 완전히 설정하려면:

1. Firebase Console에서 `youmr-test` 프로젝트 생성
2. FlutterFire CLI로 설정 파일 생성:
   ```bash
   flutterfire configure --project=youmr-test --out=lib/firebase_options_test.dart
   ```
3. 생성된 파일의 클래스명을 `TestFirebaseOptions`로 변경
4. 프로젝트 ID를 `youmr-test`로 업데이트

## 주의사항

- **프로덕션 환경**: 실제 사용자 데이터가 저장되므로 주의
- **테스트 환경**: 테스트 데이터만 사용
- **개발 환경**: 개발용 데이터만 사용
- 환경 전환 시 올바른 Firebase 프로젝트가 연결되었는지 확인

## 로그 확인

앱 실행 시 콘솔에서 현재 환경 정보를 확인할 수 있습니다:

```
🔥 Firebase 환경 정보
🌍 환경: 개발
📱 프로젝트 ID: youmr-dev
🔧 디버그 모드: true
🚀 Firebase 초기화 시작...
✅ Firebase 초기화 완료
```
