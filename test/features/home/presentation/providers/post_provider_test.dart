import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youmr_v2/features/home/domain/entities/post.dart';
import 'package:youmr_v2/features/home/domain/use_cases/get_posts_use_case.dart';
import 'package:youmr_v2/features/home/presentation/providers/post_provider.dart';

class MockGetPostsUseCase extends Mock implements GetPostsUseCase {}

void main() {
  group('PostListNotifier', () {
    late MockGetPostsUseCase mockUseCase;
    late PostListNotifier notifier;

    setUp(() {
      mockUseCase = MockGetPostsUseCase();
      notifier = PostListNotifier(getPostsUseCase: mockUseCase);
    });

    test('게시글 목록을 정상적으로 불러오면 상태가 업데이트된다', () async {
      // Given: 게시글 목록이 준비됨
      final posts = [
        Post(
          id: '1',
          authorId: 'user1',
          authorName: '홍길동',
          title: '테스트 게시글',
          content: '테스트 본문',
          category: '자유',
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
          likeCount: 0,
          commentCount: 0,
          imageUrls: [],
        ),
      ];
      when(() => mockUseCase()).thenAnswer((_) async => posts);
      // When: fetchPosts()를 호출하면
      await notifier.fetchPosts();
      // Then: 상태가 정상적으로 업데이트됨
      expect(notifier.state.posts, posts);
      expect(notifier.state.isLoading, false);
      expect(notifier.state.error, isNull);
    });

    test('게시글 불러오기 실패 시 에러 상태가 된다', () async {
      // Given: useCase가 예외를 던짐
      when(() => mockUseCase()).thenThrow(Exception('네트워크 오류'));
      // When: fetchPosts()를 호출하면
      await notifier.fetchPosts();
      // Then: 에러 상태가 됨
      expect(notifier.state.posts, isEmpty);
      expect(notifier.state.isLoading, false);
      expect(notifier.state.error, isNotNull);
    });
  });
} 