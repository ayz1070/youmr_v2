import 'package:flutter/material.dart';
import '../../domain/entities/post_entity.dart';

/// 게시글 카드 위젯
class PostCard extends StatelessWidget {
  final PostEntity post;
  final VoidCallback? onTap;
  const PostCard({Key? key, required this.post, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(post.title),
        subtitle: Text(post.content, maxLines: 2, overflow: TextOverflow.ellipsis),
        onTap: onTap,
      ),
    );
  }
} 