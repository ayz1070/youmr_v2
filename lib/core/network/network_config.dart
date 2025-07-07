/// 네트워크 기본 설정 및 상수 정의
class NetworkConfig {
  static const String baseUrl = 'https://api.youmr.com';
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 15);
  // TODO: 필요시 헤더, 토큰 등 추가
} 