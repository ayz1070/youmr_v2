import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/post_write_controller.dart';
import '../../domain/entities/post_entity.dart';

/// 게시글 작성/수정 페이지
class PostEditPage extends ConsumerWidget {
  const PostEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(postWriteControllerProvider.notifier);
    final state = ref.watch(postWriteControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('게시글 작성')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await controller.createPost(
                title: '제목',
                content: '내용',
                category: '카테고리',
                authorId: '작성자ID',
                authorNickname: '닉네임',
                authorProfileUrl: '',
              );
            },
            child: const Text('작성하기'),
          ),
          if (state.isLoading) const CircularProgressIndicator(),
          if (state.success == true) const Text('작성 성공!'),
          if (state.error != null) Text('에러: ${state.error}'),
        ],
      ),
    );
  }
} 