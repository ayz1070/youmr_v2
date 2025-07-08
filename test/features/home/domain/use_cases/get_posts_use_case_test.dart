import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youmr_v2/features/home/domain/entities/post.dart';
import 'package:youmr_v2/features/home/domain/repositories/post_repository.dart';
import 'package:youmr_v2/features/home/domain/use_cases/get_posts_use_case.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  group('GetPostsUseCase', () {
    late MockPostRepository mockRepository;
    late GetPostsUseCase useCase;

    setUp(() {
      mockRepository = MockPostRepository();
      useCase = GetPostsUseCase(repository: mockRepository);
    });

    test('게시글 목록을 정상적으로 반환한다', () async {
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
      when(() => mockRepository.getPosts()).thenAnswer((_) async => posts);
      // When: useCase를 실행하면
      final result = await useCase();
      // Then: 게시글 목록이 반환되고, 첫 번째 게시글의 제목이 올바름
      expect(result, isA<List<Post>>());
      expect(result.first.title, '테스트 게시글');
    });
  });
} 