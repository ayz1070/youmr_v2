/// 공통 도메인 에러(Failure) 타입
///
/// - 모든 도메인에서 사용 가능
/// - 한글 메시지, Exception 상속, const 생성자
class AppFailure implements Exception {
  /// 에러 메시지
  final String message;
  /// 생성자
  const AppFailure(this.message);

  /// 인증 실패 에러
  static const AppFailure unauthorized = AppFailure('인증에 실패했습니다.');
  
  /// 서버 에러
  static AppFailure serverError(String error) => AppFailure('서버 오류: $error');

  /// 유효성 검증 에러
  static AppFailure validationError(String error) => AppFailure('유효성 검증 실패: $error');

  /// 권한 부족 에러
  static AppFailure permissionDenied(String error) => AppFailure('권한이 부족합니다: $error');

  /// 리소스 없음 에러
  static AppFailure notFound(String error) => AppFailure('리소스를 찾을 수 없습니다: $error');

  /// 네트워크 에러
  static AppFailure networkError(String error) => AppFailure('네트워크 오류: $error');

  /// 캐시 에러
  static AppFailure cacheError(String error) => AppFailure('캐시 오류: $error');
} 