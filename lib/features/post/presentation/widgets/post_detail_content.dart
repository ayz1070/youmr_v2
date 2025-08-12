import 'package:flutter/material.dart';

class PostDetailContent extends StatelessWidget {
  final String content;
  final int likeCount;
const PostDetailContent({super.key, required this.content, required this.likeCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          // 좋아요/댓글 등(임시)
          // Row(
          //   children: [
          //     Icon(Icons.thumb_up_alt_outlined, size: 20, color: Theme.of(context).colorScheme.primary),
          //     const SizedBox(width: 4),
          //     Text('$likesCount', style: Theme.of(context).textTheme.bodyMedium),
          //   ],
          // ),
        ],
      ),
    );
  }
}