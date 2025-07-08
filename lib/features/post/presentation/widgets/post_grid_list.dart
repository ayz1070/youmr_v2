import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'post_card.dart';

/// 게시글 그리드 리스트 위젯
class PostGridList extends StatelessWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> posts;
  final bool hasMore;
  final ThemeData theme;
  const PostGridList({super.key, required this.posts, required this.hasMore, required this.theme});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 12,
          childAspectRatio: 0.72,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, idx) {
            if (idx >= posts.length) {
              // 로딩 인디케이터(무한 스크롤)
              return hasMore
                  ? Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    )
                  : const SizedBox.shrink();
            }
            final postData = posts[idx].data();
            return PostCard(
              postId: posts[idx].id,
              title: postData['title'] ?? '',
              content: postData['content'] ?? '',
              author: postData['authorNickname'] ?? '',
              authorProfileUrl: postData['authorProfileUrl'] ?? '',
              createdAt: postData['createdAt'] != null ? (postData['createdAt'] as Timestamp).toDate() : null,
              youtubeUrl: postData['youtubeUrl'],
              likes: postData['likes'] ?? [],
              likesCount: postData['likesCount'] ?? 0,
            );
          },
          childCount: posts.length + (hasMore ? 1 : 0),
        ),
      ),
    );
  }
} 