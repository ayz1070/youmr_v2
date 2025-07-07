# core 디렉토리 구조 및 역할

본 디렉토리는 앱 전체에서 공통적으로 사용하는 상수, 테마, 확장 함수, 유틸, 공통 위젯, 에러, 네트워크, DI(의존성 주입) 등을 관리합니다.

## 구조 예시
```
core/
├── constants/         # 앱 전체 상수 (AppConstants 등)
├── theme/             # 테마 설정 (AppTheme 등)
├── extensions/        # BuildContext 등 확장 함수
├── utils/             # 날짜 등 유틸 함수
├── widgets/           # 공통 위젯(로딩, 빈상태 등)
├── errors/            # 공통 Failure(에러) 클래스
├── network/           # 네트워크 설정/유틸
├── di/                # 앱 전체 DI(의존성 주입) provider 등록
```

## 규칙
- 모든 코드/주석/문서는 한글로 작성
- 각 계층별 역할을 명확히 분리
- riverpod provider는 core/di에서 통합 관리
- 상수, 테마, 유틸, 위젯, 에러, 네트워크 등은 core에서만 import
- feature별 provider는 core/di에서 import/재export

## 사용 예시
```dart
import 'package:youmr_v2/core/constants/app_constants.dart';
import 'package:youmr_v2/core/theme/app_theme.dart';
import 'package:youmr_v2/core/extensions/context_extensions.dart';
import 'package:youmr_v2/core/di/core_providers.dart';
``` 