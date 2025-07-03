import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../pages/post_detail_page.dart';
import 'dart:math';
import 'package:shimmer/shimmer.dart';

/// 게시글 카드 위젯
class PostCard extends StatelessWidget {
  final String postId;
  final String title;
  final String content;
  final String author;
  final String? authorProfileUrl;
  final DateTime? createdAt;
  final String? youtubeUrl;
  final List<dynamic> likes;
  final int likesCount;
  
  const PostCard({
    super.key,
    required this.postId,
    required this.title,
    required this.content,
    required this.author,
    this.authorProfileUrl,
    this.createdAt,
    this.youtubeUrl,
    this.likes = const [],
    this.likesCount = 0,
  });

  /// 유튜브 썸네일 URL 추출 (예시)
  String? getYoutubeThumbnail(String? url) {
    if (url == null) return null;
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.host.contains('youtu')) return null;
    final videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : null;
    if (videoId == null || videoId.length < 5) return null;
    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }

  @override
  Widget build(BuildContext context) {
    final thumb = getYoutubeThumbnail(youtubeUrl);
    final theme = Theme.of(context);
    final random = Random(postId.hashCode); // 카드별로 고정된 랜덤값
    // picsum 랜덤 이미지 URL (postId 해시 기반)
    final picsumId = (random.nextInt(1000) + 1).toString();
    final picsumUrl = 'https://picsum.photos/seed/$picsumId/800/420';
    
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.all(4),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => PostDetailPage(postId: postId),
            ),
          );
        },
        child: SizedBox(
          height: 210,
          child: Stack(
            children: [
              // 썸네일 배경 or 랜덤 메인색 배경
              if (thumb != null)
                Positioned.fill(
                  child: Hero(
                    tag: 'postImage_$postId',
                    child: Stack(
                      children: [
                        Image.network(
                          thumb,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          loadingBuilder: (context, child, progress) => progress == null ? child : Container(color: theme.colorScheme.surfaceContainer, width: double.infinity, height: double.infinity),
                        ),
                        Container(
                          color: Colors.black.withOpacity(0.32),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Positioned.fill(
                  child: Hero(
                    tag: 'postImage_$postId',
                    child: Stack(
                      children: [
                        Image.network(
                          picsumUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          loadingBuilder: (context, child, progress) =>
                            progress == null
                              ? child
                              : Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    color: Colors.grey[300],
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                        ),
                        Container(
                          color: Colors.black.withOpacity(0.22),
                        ),
                      ],
                    ),
                  ),
                ),
              // 카드 내용
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 최상단: 프로필/닉네임
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 13,
                            backgroundImage: (authorProfileUrl != null && authorProfileUrl!.isNotEmpty)
                                ? NetworkImage(authorProfileUrl!)
                                : const AssetImage('assets/images/default_profile.png') as ImageProvider,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            author,
                            style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12, shadows: [Shadow(color: Colors.black26, blurRadius: 2)]),
                          ),
                          const Spacer(),
                        ],
                      ),
                      const Spacer(),
                      // 제목/내용(해시태그 등)
                      Center(
                        child: Text(
                          title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 17,
                            shadows: [Shadow(color: Colors.black38, blurRadius: 4)],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // 하단: 좋아요/댓글/작성일
                      Row(
                        children: [
                          Icon(Icons.favorite_border, size: 15, color: Colors.white),
                          const SizedBox(width: 2),
                          Text('$likesCount', style: theme.textTheme.bodySmall?.copyWith(color: Colors.white, fontSize: 12)),
                          const SizedBox(width: 8),
                          Icon(Icons.mode_comment_outlined, size: 15, color: Colors.white),
                          const SizedBox(width: 2),
                          CommentCount(postId: postId),
                          if (createdAt != null) ...[
                            const SizedBox(width: 8),
                            Text(
                              _formatDate(createdAt!),
                              style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70, fontSize: 11),
                            ),
                          ],
                          const Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // 영상 플레이 아이콘(중앙)
              if (thumb != null)
                const Center(
                  child: Icon(Icons.play_circle_fill, color: Colors.white, size: 48),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (now.year == date.year && now.month == date.month && now.day == date.day) {
      // 오늘
      return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else {
      return "${date.year % 100}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}";
    }
  }
}

class CommentCount extends StatelessWidget {
  final String postId;
  const CommentCount({required this.postId});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('comments')
          .where('postId', isEqualTo: postId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2));
        final count = snapshot.data!.docs.length;
        return Text('$count', style: Theme.of(context).textTheme.bodySmall);
      },
    );
  }
}