import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:youmr_v2/features/post/data/data_sources/post_firestore_data_source.dart';

void main() {
  group('PostFirestoreDataSource', () {
    test('Given MockFirestore When fetchPosts Then 정상 동작', () async {
      // Given
      final mockFirestore = FakeFirebaseFirestore();
      await mockFirestore.collection('posts').add({
        'id': '1',
        'title': '테스트',
        'content': '내용',
        'authorId': 'user1',
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
      });
      final dataSource = PostFirestoreDataSource(firestore: mockFirestore);
      // When
      final posts = await dataSource.fetchPosts();
      // Then
      expect(posts, isNotEmpty);
      expect(posts.first.title, '테스트');
    });
  });
} 