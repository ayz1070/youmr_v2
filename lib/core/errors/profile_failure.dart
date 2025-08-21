/// 프로필 관련 에러(Failure) 계층
sealed class ProfileFailure implements Exception {
  final String message;
  const ProfileFailure(this.message);
}

/// Firestore 접근 실패
class ProfileFirestoreFailure extends ProfileFailure {
  const ProfileFirestoreFailure(super.message);
}

/// 인증/권한 에러
class ProfileAuthFailure extends ProfileFailure {
  const ProfileAuthFailure(super.message);
}

/// 알 수 없는 에러
class ProfileUnknownFailure extends ProfileFailure {
  const ProfileUnknownFailure(super.message);
} 