import '../../../domain/entities/post.dart';

class LatestNoticeState {
  /// 최신 공지글 (단일)
  final Post? notice;
  /// 로딩 여부
  final bool isLoading;
  /// 에러 메시지(있을 경우)
  final String? error;

  /// 생성자
  const LatestNoticeState({
    this.notice,
    required this.isLoading,
    this.error,
  });

  /// 초기 상태 반환
  factory LatestNoticeState.initial() => const LatestNoticeState(isLoading: false);

  /// 상태 복사 (immutable 패턴)
  LatestNoticeState copyWith({
    Post? notice,
    bool? isLoading,
    String? error,
  }) {
    return LatestNoticeState(
      notice: notice ?? this.notice,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
