import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youmr_v2/features/home/data/repositories/post_repository_impl.dart';
import 'package:youmr_v2/features/home/domain/entities/post.dart';

void main() {
  group('PostRepositoryImpl', () {
    late PostRepositoryImpl repository;

    setUp(() {
      repository = PostRepositoryImpl();
    });

    test('게시글 목록을 정상적으로 반환한다', () async {
      // Given: PostRepositoryImpl이 준비됨
      // When: getPosts()를 호출하면
      final result = await repository.getPosts();
      // Then: 게시글 목록이 반환되고, 첫 번째 게시글의 제목이 올바름
      expect(result, isA<List<Post>>());
      expect(result.first.title, '첫 번째 게시글');
    });
  });
} 