import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/errors/app_failure.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/use_cases/get_latest_notice_use_case.dart';
import '../states/latest_notice_state.dart';

/// 최신 공지글 Provider (StateNotifier)
class LatestNoticeNotifier extends StateNotifier<LatestNoticeState> {
  final GetLatestNoticeUseCase _getLatestNotice;
  StreamSubscription<Either<AppFailure, Post?>>? _noticeSubscription;

  /// 생성자
  LatestNoticeNotifier({required GetLatestNoticeUseCase getLatestNotice})
      : _getLatestNotice = getLatestNotice,
        super(LatestNoticeState.initial()) {
    _loadLatestNotice();
  }

  /// 최신 공지글 로드 (실시간 스트림)
  void _loadLatestNotice() {
    state = state.copyWith(isLoading: true, error: null);

    _noticeSubscription = _getLatestNotice(limit: 1).listen(
          (result) {
        result.fold(
              (failure) {
            state = state.copyWith(
              isLoading: false,
              error: failure.message,
            );
          },
              (notice) {
            state = state.copyWith(
              notice: notice,
              isLoading: false,
              error: null,
            );
          },
        );
      },
      onError: (error) {
        state = state.copyWith(
          isLoading: false,
          error: error.toString(),
        );
      },
    );
  }

  @override
  void dispose() {
    _noticeSubscription?.cancel();
    super.dispose();
  }
}