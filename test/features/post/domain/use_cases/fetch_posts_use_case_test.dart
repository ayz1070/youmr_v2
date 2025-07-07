import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youmr_v2/features/post/domain/entities/post_entity.dart';
import 'package:youmr_v2/features/post/domain/repositories/post_repository.dart';
import 'package:youmr_v2/features/post/domain/use_cases/fetch_posts_use_case.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  group('FetchPostsUseCase', () {
    test('Given PostRepository When call Then 게시글 목록 반환', () async {
      // Given
      final mockRepo = MockPostRepository();
      final useCase = FetchPostsUseCase(mockRepo);
      // PostEntity 생성 시 authorNickname, authorProfileUrl, category 등 필수 파라미터 추가
      final post = PostEntity(
        id: '1',
        title: '제목',
        content: '내용',
        authorId: 'user1',
        authorNickname: '닉네임',
        authorProfileUrl: 'profileUrl',
        category: '카테고리',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      when(() => mockRepo.fetchPosts(category: any(named: 'category'), startAfterId: any(named: 'startAfterId'), limit: any(named: 'limit')))
        .thenAnswer((_) async => [post]);
      // When
      final result = await useCase();
      // Then
      expect(result, [post]);
      verify(() => mockRepo.fetchPosts(category: null, startAfterId: null, limit: 20)).called(1);
    });
  });
} 