import 'package:flutter_test/flutter_test.dart';
import 'package:youmr_v2/features/post/domain/entities/post_entity.dart';

void main() {
  group('PostEntity', () {
    test('Given 필수 값으로 생성 When getter 사용 Then 값이 일치해야 한다', () {
      // Given
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
      // When & Then
      expect(post.id, '1');
      expect(post.title, '제목');
      expect(post.content, '내용');
      expect(post.authorId, 'user1');
      expect(post.authorNickname, '닉네임');
      expect(post.authorProfileUrl, 'profileUrl');
      expect(post.category, '카테고리');
      expect(post.createdAt, DateTime.now());
      expect(post.updatedAt, DateTime.now());
    });
  });
} 