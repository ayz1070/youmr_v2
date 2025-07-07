import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youmr_v2/features/post/presentation/pages/post_list_page.dart';
import 'package:youmr_v2/features/post/presentation/controllers/post_controller.dart';
import 'package:youmr_v2/features/post/domain/entities/post_entity.dart';

void main() {
  testWidgets('Given posts When PostListPage 빌드 Then 게시글 목록 노출', (tester) async {
    // Given
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
    final posts = [post];
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          postControllerProvider.overrideWith((ref) => AsyncData(PostState(posts: posts))),
        ],
        child: const MaterialApp(home: PostListPage()),
      ),
    );
    // Then
    expect(find.text('제목'), findsOneWidget);
    expect(find.text('내용'), findsOneWidget);
  });

  testWidgets('Given 로딩 When PostListPage 빌드 Then 로딩 인디케이터 노출', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          postControllerProvider.overrideWith((ref) => const AsyncLoading()),
        ],
        child: const MaterialApp(home: PostListPage()),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Given 에러 When PostListPage 빌드 Then 에러 메시지 노출', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          postControllerProvider.overrideWith((ref) => const AsyncError('에러', null)),
        ],
        child: const MaterialApp(home: PostListPage()),
      ),
    );
    expect(find.textContaining('에러'), findsOneWidget);
  });
} 