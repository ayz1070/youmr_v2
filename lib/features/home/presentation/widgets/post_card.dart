import 'package:flutter/material.dart';

/// 게시글 카드 위젯 (이전 디자인 복원)
/// 썸네일, 프로필, 랜덤 이미지, 유튜브, 좋아요, 댓글, 작성일 등 포함
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

  /// 유튜브 썸네일 URL 추출
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
    final theme = Theme.of(context);
    final thumb = getYoutubeThumbnail(youtubeUrl);
    // 랜덤 이미지 URL (postId 해시 기반)
    final picsumId = postId.hashCode.abs() % 1000;
    final picsumUrl = 'https://picsum.photos/seed/$picsumId/800/420';
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: SizedBox(
          height: 210,
          child: Stack(
            children: [
              // 썸네일 배경 or 랜덤 이미지
              Positioned.fill(
                child: Hero(
                  tag: 'postImage_$postId',
                  child: Stack(
                    children: [
                      if (thumb != null)
                        Image.network(
                          thumb,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                      else
                        Image.network(
                          picsumUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
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
                      // 상단: 프로필/닉네임
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
                      // 제목/내용
                      Center(
                        child: Text(
                          title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 17,
                            shadows: [Shadow(color: Colors.black38, blurRadius: 4)],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Center(
                        child: Text(
                          content,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontSize: 13,
                            shadows: [Shadow(color: Colors.black26, blurRadius: 2)],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Spacer(),
                      // 하단: 좋아요/댓글/작성일
                      Row(
                        children: [
                          Icon(Icons.thumb_up_alt_outlined, size: 15, color: Colors.white),
                          const SizedBox(width: 2),
                          Text('$likesCount', style: theme.textTheme.bodySmall?.copyWith(color: Colors.white, fontSize: 12)),
                          const SizedBox(width: 8),
                          Icon(Icons.mode_comment_outlined, size: 15, color: Colors.white),
                          const SizedBox(width: 2),
                          // 댓글 수는 외부에서 별도 위젯으로 처리 가능
                          Text('0', style: theme.textTheme.bodySmall?.copyWith(color: Colors.white, fontSize: 12)),
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
      return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}' ;
    } else {
      return "${date.year % 100}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}";
    }
  }
}