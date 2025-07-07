import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../post_providers.dart';
import '../controllers/post_controller.dart';

/// 게시글 상세 페이지
class PostDetailPage extends ConsumerWidget {
  final String postId;
  const PostDetailPage({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postController = ref.read(postControllerProvider.notifier);
    return FutureBuilder(
      future: postController.fetchPostDetail(postId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('에러: \\${snapshot.error}')),
          );
        }
        final post = snapshot.data;
        if (post == null) {
          return const Scaffold(
            body: Center(child: Text('게시글을 찾을 수 없습니다.')),
          );
        }
        return Scaffold(
          appBar: AppBar(title: Text(post.title)),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(post.content),
          ),
        );
      },
    );
  }
} 