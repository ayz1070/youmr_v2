import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data/data_sources/post_firestore_data_source.dart';
import 'data/repositories/post_repository_impl.dart';
import 'domain/repositories/post_repository.dart';
import 'domain/use_cases/fetch_posts_use_case.dart';
import 'domain/use_cases/fetch_post_detail_use_case.dart';
import 'domain/use_cases/save_post_use_case.dart';
import 'domain/use_cases/delete_post_use_case.dart';
import 'domain/use_cases/create_post_use_case.dart';
import 'presentation/controllers/post_controller.dart';

/// 게시글 관련 의존성 주입 provider 모음

// 데이터소스 provider
final postFirestoreDataSourceProvider = Provider<PostFirestoreDataSource>((ref) {
  return PostFirestoreDataSource();
});

// 리포지토리 provider
final postRepositoryProvider = Provider<PostRepository>((ref) {
  final dataSource = ref.watch(postFirestoreDataSourceProvider);
  return PostRepositoryImpl(dataSource);
});

// 유스케이스 provider
final fetchPostsUseCaseProvider = Provider<FetchPostsUseCase>((ref) {
  final repository = ref.watch(postRepositoryProvider);
  return FetchPostsUseCase(repository);
});
final fetchPostDetailUseCaseProvider = Provider<FetchPostDetailUseCase>((ref) {
  final repository = ref.watch(postRepositoryProvider);
  return FetchPostDetailUseCase(repository);
});
final savePostUseCaseProvider = Provider<SavePostUseCase>((ref) {
  final repository = ref.watch(postRepositoryProvider);
  return SavePostUseCase(repository);
});
final deletePostUseCaseProvider = Provider<DeletePostUseCase>((ref) {
  final repository = ref.watch(postRepositoryProvider);
  return DeletePostUseCase(repository);
});
final createPostUseCaseProvider = Provider<CreatePostUseCase>((ref) {
  final repository = ref.watch(postRepositoryProvider);
  return CreatePostUseCase(repository);
});

// 컨트롤러 provider
final postControllerProvider = AsyncNotifierProvider<PostController, PostState>(
  PostController.new,
); 