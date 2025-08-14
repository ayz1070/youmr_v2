import 'package:freezed_annotation/freezed_annotation.dart';

part 'voting_failure.freezed.dart';

/// 투표 도메인 에러 타입 정의
/// 모든 메시지는 한글로 작성
@freezed
class VotingFailure with _$VotingFailure {
  /// 네트워크 오류
  const factory VotingFailure.networkFailure() = VotingNetworkFailure;
  
  /// 피크 초과 오류
  const factory VotingFailure.pickExceedFailure() = VotingPickExceedFailure;
  
  /// 이미 오늘 피크를 받음
  const factory VotingFailure.alreadyPickedFailure() = VotingAlreadyPickedFailure;
  
  /// 곡 중복 등록 오류
  const factory VotingFailure.alreadyRegisteredFailure() = VotingAlreadyRegisteredFailure;
  
  /// 권한 오류
  const factory VotingFailure.permissionFailure() = VotingPermissionFailure;
  
  /// 투표를 찾을 수 없음
  const factory VotingFailure.voteNotFoundFailure() = VotingVoteNotFoundFailure;
} 