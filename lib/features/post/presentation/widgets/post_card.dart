import 'package:flutter/material.dart';

import '../pages/post_detail_page.dart';
import 'comment_count.dart';

/// 게시글 카드 위젯 (이전 디자인 복원)
///
/// - 썸네일, 프로필, 랜덤 이미지, 유튜브, 좋아요, 댓글, 작성일 등 포함
/// - 컬러/문구/패딩 등은 core/constants로 상수화 권장
/// - 접근성(semantic label 등) 고려 권장
class PostCard extends StatelessWidget {
  /// 게시글 ID
  final String postId;
  /// 게시글 제목
  final String title;
  /// 게시글 내용
  final String content;
  /// 작성자 닉네임
  final String author;
  /// 작성자 프로필 이미지 URL
  final String? authorProfileUrl;
  /// 작성일
  final DateTime? createdAt;
  /// 유튜브 URL
  final String? youtubeUrl;
  /// 좋아요 UID 리스트
  final List<dynamic> likes;
  /// 좋아요 수
  final int likesCount;

  /// 생성자
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
  /// [url] : 유튜브 URL
  /// return : 썸네일 이미지 URL
  String? getYoutubeThumbnail(String? url) {
    if (url == null) return null;
    final Uri? uri = Uri.tryParse(url);
    if (uri == null || !uri.host.contains('youtu')) return null;
    final String? videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : null;
    if (videoId == null || videoId.length < 5) return null;
    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String? thumb = getYoutubeThumbnail(youtubeUrl);
    // 랜덤 이미지 URL (postId 해시 기반)
    final int picsumId = postId.hashCode.abs() % 1000;
    final String picsumUrl = 'https://picsum.photos/seed/$picsumId/800/420';
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
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

  /// 작성일 포맷 변환
  /// [date] : 작성일
  /// return : 포맷된 날짜 문자열
  String _formatDate(DateTime date) {
    final DateTime now = DateTime.now();
    if (now.year == date.year && now.month == date.month && now.day == date.day) {
      // 오늘
      return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}' ;
    } else {
      return "${date.year % 100}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}";
    }
  }
}