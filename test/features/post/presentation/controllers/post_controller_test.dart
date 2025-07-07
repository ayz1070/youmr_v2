import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youmr_v2/features/post/presentation/controllers/post_controller.dart';
import 'package:youmr_v2/features/post/domain/use_cases/fetch_posts_use_case.dart';
import 'package:youmr_v2/features/post/domain/use_cases/fetch_post_detail_use_case.dart';
import 'package:youmr_v2/features/post/domain/use_cases/save_post_use_case.dart';
import 'package:youmr_v2/features/post/domain/use_cases/delete_post_use_case.dart';
import 'package:youmr_v2/features/post/domain/entities/post_entity.dart';

class MockFetchPostsUseCase extends Mock implements FetchPostsUseCase {}
class MockFetchPostDetailUseCase extends Mock implements FetchPostDetailUseCase {}
class MockSavePostUseCase extends Mock implements SavePostUseCase {}
class MockDeletePostUseCase extends Mock implements DeletePostUseCase {}

void main() {
  group('PostController', () {
    late PostController controller;
    late MockFetchPostsUseCase fetchPostsUseCase;
    late MockFetchPostDetailUseCase fetchPostDetailUseCase;
    late MockSavePostUseCase savePostUseCase;
    late MockDeletePostUseCase deletePostUseCase;

    setUp(() {
      fetchPostsUseCase = MockFetchPostsUseCase();
      fetchPostDetailUseCase = MockFetchPostDetailUseCase();
      savePostUseCase = MockSavePostUseCase();
      deletePostUseCase = MockDeletePostUseCase();
      controller = PostController()
        .._fetchPostsUseCase = fetchPostsUseCase
        .._fetchPostDetailUseCase = fetchPostDetailUseCase
        .._savePostUseCase = savePostUseCase
        .._deletePostUseCase = deletePostUseCase;
    });

    test('Given fetchPosts 성공 When fetchPosts 호출 Then 상태가 posts로 변경', () async {
      // Given
      final posts = [PostEntity(id: '1', title: 't', content: 'c', authorId: 'a', createdAt: DateTime.now(), updatedAt: DateTime.now())];
      when(() => fetchPostsUseCase(category: any(named: 'category'))).thenAnswer((_) async => posts);
      // When
      await controller.fetchPosts();
      // Then
      expect(controller.debugState.valueOrNull?.posts, posts);
    });
  });
} 