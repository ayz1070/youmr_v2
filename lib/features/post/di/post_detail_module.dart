import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youmr_v2/features/post/di/post_module.dart' as PostModule;
import 'package:youmr_v2/features/post/domain/repositories/post_repository.dart';
import 'package:youmr_v2/features/post/domain/use_cases/check_post_permission.dart';
import 'package:youmr_v2/features/post/di/post_module.dart';

import '../domain/use_cases/check_like_status.dart';
import '../domain/use_cases/fetch_like_info.dart';
import '../domain/use_cases/toggle_like.dart';
import '../presentation/providers/notifiers/post_detail_notifier.dart';
import '../presentation/providers/states/post_detail_state.dart';

final postDetailProvider =
    StateNotifierProvider.family<PostDetailNotifier, PostDetailState, String>((
      ref,
      postId,
    ) {
      final notifier = PostDetailNotifier(
        postRepository: ref.watch(PostModule.postRepositoryProvider),
        checkPostPermission: CheckPostPermission(),
      );

      // 초기 데이터 로드
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifier.fetchPost(postId);
      });

      return notifier;
    });

/// 좋아요 관련 UseCase Provider들
final fetchLikeInfoProvider = Provider<FetchLikeInfo>((ref) {
  return FetchLikeInfo(
    repository: ref.watch(PostModule.postRepositoryProvider),
  );
});

final toggleLikeProvider = Provider<ToggleLike>((ref) {
  return ToggleLike(repository: ref.watch(PostModule.postRepositoryProvider));
});

final checkLikeStatusProvider = Provider<CheckLikeStatus>((ref) {
  return CheckLikeStatus(
    repository: ref.watch(PostModule.postRepositoryProvider),
  );
});
