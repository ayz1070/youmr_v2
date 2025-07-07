import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youmr_v2/features/post/data/data_sources/post_firestore_data_source.dart';
import 'package:youmr_v2/features/post/data/repositories/post_repository_impl.dart';
import 'package:youmr_v2/features/post/domain/entities/post_entity.dart';

class MockPostFirestoreDataSource extends Mock implements PostFirestoreDataSource {}

void main() {
  group('PostRepositoryImpl', () {
    test('Given 데이터소스 When fetchPosts Then Entity 리스트 반환', () async {
      // Given
      final mockDataSource = MockPostFirestoreDataSource();
      final repo = PostRepositoryImpl(mockDataSource);
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
      when(() => mockDataSource.fetchPosts(category: any(named: 'category'), startAfterId: any(named: 'startAfterId'), limit: any(named: 'limit')))
        .thenAnswer((_) async => [post]);
      // When
      final result = await repo.fetchPosts();
      // Then
      expect(result, [post]);
      verify(() => mockDataSource.fetchPosts(category: null, startAfterId: null, limit: 20)).called(1);
    });
  });
} 