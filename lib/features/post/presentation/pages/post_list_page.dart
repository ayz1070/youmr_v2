import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/post_controller.dart';
import '../widgets/post_card.dart';
import 'post_detail_page.dart';
import 'post_edit_page.dart';

/// 게시글 목록 페이지
class PostListPage extends ConsumerWidget {
  const PostListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postState = ref.watch(postControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('게시글 목록'),
      ),
      body: postState.when(
        data: (state) {
          if (state.posts.isEmpty) {
            return const Center(child: Text('게시글이 없습니다.'));
          }
          return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              final post = state.posts[index];
              return PostCard(
                post: post,
                onTap: () {
                  // 상세 페이지로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PostDetailPage(postId: post.id),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('에러: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 글쓰기(작성) 페이지로 이동
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const PostEditPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
} 