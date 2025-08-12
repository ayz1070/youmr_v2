import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/data_sources/post_firestore_data_source.dart';
import '../data/repositories/post_repository_impl.dart';
import '../domain/repositories/post_repository.dart';
import '../domain/use_cases/get_latest_notice_use_case.dart';
import '../domain/use_cases/get_notices_use_case.dart';
import '../domain/use_cases/get_posts_stream_use_case.dart';
import '../presentation/providers/notifiers/latest_notice_notifier.dart';
import '../presentation/providers/notifiers/post_list_notifier.dart';
import '../presentation/providers/notifiers/post_write_notifier.dart';
import '../presentation/providers/states/latest_notice_state.dart';
import '../presentation/providers/states/post_list_state.dart';
import '../presentation/providers/states/post_write_state.dart';

/// 게시글 목록 Provider 인스턴스
final postListProvider = StateNotifierProvider<PostListNotifier, PostListState>(
  (ref) => PostListNotifier(
    getPostsStream: ref.watch(getPostsStreamUseCaseProvider),
    getNotices: ref.watch(getNoticesUseCaseProvider),
  ),
);

final postWriteProvider =
    StateNotifierProvider<PostWriteNotifier, PostWriteState>(
      (ref) =>
          PostWriteNotifier(postRepository: ref.watch(postRepositoryProvider)),
    );

/// 최신 공지글 Provider 인스턴스
final latestNoticeProvider =
    StateNotifierProvider<LatestNoticeNotifier, LatestNoticeState>(
      (ref) => LatestNoticeNotifier(
        getLatestNotice: ref.watch(getLatestNoticeUseCaseProvider),
      ),
    );

/// UseCase Provider들
final getPostsStreamUseCaseProvider = Provider<GetPostsStreamUseCase>((ref) {
  return GetPostsStreamUseCase(repository: ref.watch(postRepositoryProvider));
});

final getNoticesUseCaseProvider = Provider<GetNoticesUseCase>((ref) {
  return GetNoticesUseCase(repository: ref.watch(postRepositoryProvider));
});

final getLatestNoticeUseCaseProvider = Provider<GetLatestNoticeUseCase>((ref) {
  return GetLatestNoticeUseCase(repository: ref.watch(postRepositoryProvider));
});

/// Repository Provider
final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepositoryImpl(dataSource: PostFirestoreDataSource());
});
