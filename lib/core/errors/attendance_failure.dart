/// 출석 관련 에러(Failure) 계층
sealed class AttendanceFailure implements Exception {
  final String message;
  const AttendanceFailure(this.message);
}

/// Firestore 접근 실패
class AttendanceFirestoreFailure extends AttendanceFailure {
  const AttendanceFirestoreFailure(super.message);
}

/// 알 수 없는 에러
class AttendanceUnknownFailure extends AttendanceFailure {
  const AttendanceUnknownFailure(super.message);
} 