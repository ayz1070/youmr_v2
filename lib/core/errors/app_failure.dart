/// 공통 도메인 에러(Failure) 타입
///
/// - 모든 도메인에서 사용 가능
/// - 한글 메시지, Exception 상속, const 생성자
class AppFailure implements Exception {
  /// 에러 메시지
  final String message;
  /// 생성자
  const AppFailure(this.message);
} 