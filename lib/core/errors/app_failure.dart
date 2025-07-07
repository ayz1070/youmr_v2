/// 앱 전역 공통 Failure(에러) 추상 클래스 및 예시 구현
abstract class AppFailure implements Exception {
  final String message;
  final Exception? cause;
  const AppFailure(this.message, {this.cause});

  @override
  String toString() => '$runtimeType: $message';
}

/// 네트워크 에러
class NetworkFailure extends AppFailure {
  const NetworkFailure(String message, {Exception? cause}) : super(message, cause: cause);
}

/// 인증 에러
class AuthFailure extends AppFailure {
  const AuthFailure(String message, {Exception? cause}) : super(message, cause: cause);
}

/// 알 수 없는 에러
class UnknownFailure extends AppFailure {
  const UnknownFailure(String message, {Exception? cause}) : super(message, cause: cause);
} 