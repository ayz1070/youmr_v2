/// 에러 메시지 상수 모음
class ErrorMessages {
  /// 공통 에러 메시지
  static const String commonError = '에러가 발생했습니다.';
  
  /// attendance 관련 에러 메시지
  static const String attendanceLoadError = '출석 정보를 불러오지 못했습니다.';
  static const String attendanceSaveError = '출석 정보를 저장하지 못했습니다.';
  static const String attendanceStreamError = '출석 정보 스트림을 불러오지 못했습니다.';
  static const String attendanceDeleteError = '출석 정보를 삭제하지 못했습니다.';
  static const String emptyAttendance = '출석 데이터가 없습니다.';
  static const String userProfileLoadError = '사용자 프로필 정보를 불러오지 못했습니다.';
  static const String userNotFoundError = '사용자 정보를 찾을 수 없습니다.';
  
  /// 투표: 보유 피크보다 많은 곡 선택 시
  static const String votingPickExceedError = '보유 피크보다 많은 곡을 선택할 수 없습니다.';
  /// 투표: 이미 오늘 피크를 받은 경우
  static const String votingAlreadyPickedError = '이미 오늘 피크를 받았습니다.';
  /// 투표: 이미 등록된 곡일 때
  static const String votingAlreadyRegisteredError = '이미 등록된 곡입니다.';
  /// 투표: 곡을 찾을 수 없는 경우
  static const String votingVoteNotFoundError = '곡을 찾을 수 없습니다.';
  /// 투표: 삭제 권한이 없는 경우
  static const String votingPermissionDeniedError = '삭제 권한이 없습니다.';
} 