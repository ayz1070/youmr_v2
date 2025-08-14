/// 인증 관련 에러(Failure) 계층
sealed class AuthFailure implements Exception {
  final String message;
  const AuthFailure(this.message);
}

/// Firebase 인증 실패
class AuthFirebaseFailure extends AuthFailure {
  const AuthFirebaseFailure(super.message);
}

/// Firestore 접근 실패
class AuthFirestoreFailure extends AuthFailure {
  const AuthFirestoreFailure(super.message);
}

/// 알 수 없는 에러
class AuthUnknownFailure extends AuthFailure {
  const AuthUnknownFailure(super.message);
} 