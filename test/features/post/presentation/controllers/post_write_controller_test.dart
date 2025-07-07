import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youmr_v2/features/post/presentation/controllers/post_write_controller.dart';
import 'package:youmr_v2/features/post/domain/use_cases/create_post_use_case.dart';

class MockCreatePostUseCase extends Mock implements CreatePostUseCase {}

void main() {
  group('PostWriteController', () {
    late MockCreatePostUseCase mockCreatePostUseCase;
    late PostWriteController controller;

    setUp(() {
      mockCreatePostUseCase = MockCreatePostUseCase();
      controller = PostWriteController();
      controller._createPostUseCase = mockCreatePostUseCase;
    });

    test('게시글 작성 성공 시 상태가 success=true로 변경된다', () async {
      // Given
      when(() => mockCreatePostUseCase(
        title: any(named: 'title'),
        content: any(named: 'content'),
        category: any(named: 'category'),
        authorId: any(named: 'authorId'),
        authorNickname: any(named: 'authorNickname'),
        authorProfileUrl: any(named: 'authorProfileUrl'),
        youtubeUrl: any(named: 'youtubeUrl'),
      )).thenAnswer((_) async {});

      // When
      await controller.createPost(
        title: '제목',
        content: '내용',
        category: '카테고리',
        authorId: '작성자ID',
        authorNickname: '닉네임',
        authorProfileUrl: '',
      );

      // Then
      expect(controller.state.value?.success, true);
    });

    test('게시글 작성 실패 시 상태가 error로 변경된다', () async {
      // Given
      when(() => mockCreatePostUseCase(
        title: any(named: 'title'),
        content: any(named: 'content'),
        category: any(named: 'category'),
        authorId: any(named: 'authorId'),
        authorNickname: any(named: 'authorNickname'),
        authorProfileUrl: any(named: 'authorProfileUrl'),
        youtubeUrl: any(named: 'youtubeUrl'),
      )).thenThrow(Exception('작성 실패'));

      // When
      await controller.createPost(
        title: '제목',
        content: '내용',
        category: '카테고리',
        authorId: '작성자ID',
        authorNickname: '닉네임',
        authorProfileUrl: '',
      );

      // Then
      expect(controller.state.hasError, true);
    });
  });
} 