/// 에러 메시지 상수 모음
class ErrorMessages {
  static const String commonError = '에러가 발생했습니다.';
  static const String attendanceLoadError = '출석 정보를 불러오지 못했습니다.';
  static const String emptyAttendance = '출석 데이터가 없습니다.';
  /// 투표: 보유 피크보다 많은 곡 선택 시
  static const String votingPickExceedError = '보유 피크보다 많은 곡을 선택할 수 없습니다.';
  /// 투표: 이미 오늘 피크를 받은 경우
  static const String votingAlreadyPickedError = '이미 오늘 피크를 받았습니다.';
  /// 투표: 이미 등록된 곡일 때
  static const String votingAlreadyRegisteredError = '이미 등록된 곡입니다.';
} 