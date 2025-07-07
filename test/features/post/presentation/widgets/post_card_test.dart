import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youmr_v2/features/post/presentation/widgets/post_card.dart';
import 'package:youmr_v2/features/post/domain/entities/post_entity.dart';

void main() {
  testWidgets('Given PostEntity When PostCard 빌드 Then 제목/내용이 노출된다', (tester) async {
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
    // When
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: PostCard(post: post)),
    ));
    // Then
    expect(find.text('테스트 제목'), findsOneWidget);
    expect(find.textContaining('테스트 내용'), findsOneWidget);
  });
} 