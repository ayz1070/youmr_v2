import 'package:flutter/material.dart';
import '../../domain/entities/post.dart';
import 'post_card.dart';

/// 게시글 그리드 리스트 위젯
class PostGridList extends StatelessWidget {
  final List<Post> posts;
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
            final post = posts[idx];
            return PostCard(
              postId: post.id,
              title: post.title,
              content: post.content,
              author: post.authorNickname,
              authorProfileUrl: post.authorProfileUrl, // Post 엔티티의 authorProfileUrl 사용
              createdAt: post.createdAt,
              youtubeUrl: post.youtubeUrl.isNotEmpty ? post.youtubeUrl : null,
              likes: post.likes,
              likeCount: post.likeCount,
              backgroundImage: post.backgroundImage.isNotEmpty 
                  ? post.backgroundImage 
                  : 'https://picsum.photos/seed/${post.id}/800/420',
            );
          },
          childCount: posts.length + (hasMore ? 1 : 0),
        ),
      ),
    );
  }
} 