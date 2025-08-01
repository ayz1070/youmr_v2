/// 투표 도메인 에러 타입 정의
/// 모든 메시지는 한글로 작성
abstract class VotingFailure {
  final String message;
  const VotingFailure(this.message);
}

/// 네트워크 오류
class VotingNetworkFailure extends VotingFailure {
  const VotingNetworkFailure() : super('네트워크 오류가 발생했습니다.');
}

/// 피크 초과 오류
class VotingPickExceedFailure extends VotingFailure {
  const VotingPickExceedFailure() : super('보유 피크보다 많은 곡을 선택했습니다.');
}

/// 이미 오늘 피크를 받음
class VotingAlreadyPickedFailure extends VotingFailure {
  const VotingAlreadyPickedFailure() : super('오늘 이미 피크를 받았습니다.');
}

/// 곡 중복 등록 오류
class VotingAlreadyRegisteredFailure extends VotingFailure {
  const VotingAlreadyRegisteredFailure() : super('이미 등록된 곡입니다.');
}

/// 알 수 없는 오류
class VotingUnknownFailure extends VotingFailure {
  const VotingUnknownFailure() : super('알 수 없는 오류가 발생했습니다.');
}

/// 권한 오류
class VotingPermissionFailure extends VotingFailure {
  const VotingPermissionFailure() : super('삭제 권한이 없습니다.');
} 