import 'package:freezed_annotation/freezed_annotation.dart';

part 'voting_write_state.freezed.dart';

/// 투표 작성 상태
@freezed
class VotingWriteState with _$VotingWriteState {
  /// 초기 상태
  const factory VotingWriteState.initial() = _Initial;
  
  /// 로딩 상태
  const factory VotingWriteState.loading() = _Loading;
  
  /// 성공 상태
  const factory VotingWriteState.success() = _Success;
  
  /// 에러 상태
  const factory VotingWriteState.error(String message) = _Error;
}
