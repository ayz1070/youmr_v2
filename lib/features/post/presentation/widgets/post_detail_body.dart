import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'comment_count.dart';

String? _getYoutubeThumbnail(String? url) {
  if (url == null) return null;
  final uri = Uri.tryParse(url);
  if (uri == null || !uri.host.contains('youtu')) return null;
  final videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : null;
  if (videoId == null || videoId.length < 5) return null;
  return 'https://img.youtube.com/vi/$videoId/0.jpg';
}

/// YouTube 링크로 이동하는 함수
Future<void> _launchYoutubeUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw Exception('YouTube 링크를 열 수 없습니다.');
  }
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

/// 게시글 상세 본문 위젯
class PostDetailBody extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>>? post;
  final YoutubePlayerController? ytController;
  final bool isLoading;
  final String? error;
  const PostDetailBody({super.key, required this.post, required this.ytController, required this.isLoading, this.error});

  @override
  Widget build(BuildContext context) {
    if (post == null) {
      return const Center(child: Text('게시글 정보가 없습니다.'));
    }
    final data = post!.data();
    if (data == null) {
      return const Center(child: Text('게시글 데이터가 없습니다.'));
    }
    final postId = post!.id;
    final title = data['title'] ?? '';
    final content = data['content'] ?? '';
    final author = data['authorNickname'] ?? '';
    final authorProfileUrl = data['authorProfileUrl'] ?? '';
    final createdAt = data['createdAt'] != null ? (data['createdAt'] as Timestamp).toDate() : null;
    final youtubeUrl = data['youtubeUrl'];
    final likesCount = data['likesCount'] ?? 0;
    final thumb = _getYoutubeThumbnail(youtubeUrl);
    final picsumId = postId.hashCode.abs() % 1000;
    final picsumUrl = 'https://picsum.photos/seed/$picsumId/800/420';
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostDetailHeader(
            postId: postId,
            thumb: thumb,
            picsumUrl: picsumUrl,
            author: author,
            authorProfileUrl: authorProfileUrl,
            createdAt: createdAt,
            title: title,
            likesCount: likesCount,
            youtubeUrl: youtubeUrl,
          ),
          PostDetailContent(content: content, likesCount: likesCount),
        ],
      ),
    );
  }
}

class PostDetailHeader extends StatefulWidget {
  final String postId;
  final String? thumb;
  final String picsumUrl;
  final String author;
  final String authorProfileUrl;
  final DateTime? createdAt;
  final String title;
  final int likesCount;
  final String? youtubeUrl;
  const PostDetailHeader({super.key, required this.postId, required this.thumb, required this.picsumUrl, required this.author, required this.authorProfileUrl, required this.createdAt, required this.title, required this.likesCount, this.youtubeUrl});

  @override
  State<PostDetailHeader> createState() => _PostDetailHeaderState();
}

class _PostDetailHeaderState extends State<PostDetailHeader> {
  bool _liked = false; // 기본값으로 초기화
  late int _likesCount;

  @override
  void initState() {
    super.initState();
    _likesCount = widget.likesCount;
    _fetchLikes();
  }

  Future<void> _fetchLikes() async {
    final doc = await FirebaseFirestore.instance.collection('posts').doc(widget.postId).get();
    final likes = List<String>.from(doc['likes'] ?? []);
    final uid = FirebaseAuth.instance.currentUser?.uid;
    setState(() {
      _liked = uid != null && likes.contains(uid);
      _likesCount = doc['likesCount'] ?? likes.length;
    });
  }

  Future<void> _toggleLike() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final ref = FirebaseFirestore.instance.collection('posts').doc(widget.postId);
    setState(() {
      if (_liked) {
        _liked = false;
        _likesCount--;
      } else {
        _liked = true;
        _likesCount++;
      }
    });
    try {
      await FirebaseFirestore.instance.runTransaction((tx) async {
        final snap = await tx.get(ref);
        final likes = List<String>.from(snap['likes'] ?? []);
        final likesCount = snap['likesCount'] ?? 0;
        if (likes.contains(uid)) {
          likes.remove(uid);
          tx.update(ref, {'likes': likes, 'likesCount': likesCount - 1});
        } else {
          likes.add(uid);
          tx.update(ref, {'likes': likes, 'likesCount': likesCount + 1});
        }
      });
    } catch (e) {
      setState(() {
        if (_liked) {
          _liked = false;
          _likesCount--;
        } else {
          _liked = true;
          _likesCount++;
        }
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('좋아요 처리에 실패했습니다.')),
        );
      }
    }
    await _fetchLikes();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: 'postImage_${widget.postId}',
          child: SizedBox(
            width: double.infinity,
            height: 320,
            child: (widget.thumb != null)
                ? Image.network(widget.thumb!, fit: BoxFit.cover)
                : Image.network(widget.picsumUrl, fit: BoxFit.cover),
          ),
        ),
        Container(
          width: double.infinity,
          height: 320,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.55),
              ],
            ),
          ),
        ),
        if (widget.thumb != null)
          Positioned.fill(
            child: Center(
              child: GestureDetector(
                onTap: () {
                  if (widget.youtubeUrl != null && widget.youtubeUrl!.isNotEmpty) {
                    _launchYoutubeUrl(widget.youtubeUrl!);
                  }
                },
                child: Container(
                  width: 70,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE53E3E), // YouTube 빨간색
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: (widget.authorProfileUrl.isNotEmpty)
                          ? NetworkImage(widget.authorProfileUrl)
                          : const AssetImage('assets/images/default_profile.png') as ImageProvider,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.author,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [Shadow(color: Colors.black45, blurRadius: 2)],
                          ),
                    ),
                    const Spacer(),
                    if (widget.createdAt != null)
                      Text(
                        _formatDate(widget.createdAt!),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white70,
                              shadows: [Shadow(color: Colors.black38, blurRadius: 2)],
                            ),
                      ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: _toggleLike,
                      child: Icon(
                        _liked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                        size: 18,
                        color: Colors.white,
                        shadows: [Shadow(color: Colors.black38, blurRadius: 2)],
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text('$_likesCount', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white, shadows: [Shadow(color: Colors.black38, blurRadius: 2)])),
                    const SizedBox(width: 12),
                    Icon(Icons.mode_comment_outlined, size: 18, color: Colors.white, shadows: [Shadow(color: Colors.black38, blurRadius: 2)]),
                    const SizedBox(width: 4),
                    CommentCount(postId: widget.postId),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PostDetailContent extends StatelessWidget {
  final String content;
  final int likesCount;
  const PostDetailContent({super.key, required this.content, required this.likesCount});

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