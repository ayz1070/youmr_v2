
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youmr_v2/features/post/di/post_module.dart';

import '../domain/use_cases/check_like_status.dart';
import '../domain/use_cases/check_post_permission.dart';
import '../domain/use_cases/fetch_like_info.dart';
import '../domain/use_cases/toggle_like.dart';
import '../presentation/providers/notifiers/post_detail_notifier.dart';
import '../presentation/providers/states/post_detail_state.dart';

/// PostDetailNotifier Provider
final postDetailProvider = StateNotifierProvider.family<PostDetailNotifier, PostDetailState, String>(
      (ref, postId) {
    final notifier = PostDetailNotifier(
      postRepository: ref.watch(postRepositoryProvider),
      checkPostPermission: CheckPostPermission(),
    );

    // 초기 데이터 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifier.fetchPost(postId);
    });

    return notifier;
  },
);

/// 좋아요 관련 UseCase Provider들
final fetchLikeInfoProvider = Provider<FetchLikeInfo>((ref) {
  return FetchLikeInfo(repository: ref.watch(postRepositoryProvider));
});

final toggleLikeProvider = Provider<ToggleLike>((ref) {
  return ToggleLike(repository: ref.watch(postRepositoryProvider));
});

final checkLikeStatusProvider = Provider<CheckLikeStatus>((ref) {
  return CheckLikeStatus(repository: ref.watch(postRepositoryProvider));
});