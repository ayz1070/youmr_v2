import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../widgets/comment_list.dart';
import '../widgets/comment_input.dart';
import '../widgets/like_button.dart';
import 'post_edit_page.dart';
import 'package:uuid/uuid.dart';
import '../widgets/post_card.dart';
import 'dart:math';
import 'package:shimmer/shimmer.dart';

/// 게시글 상세 + 댓글 페이지
class PostDetailPage extends StatefulWidget {
  final String postId;
  const PostDetailPage({super.key, required this.postId});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  DocumentSnapshot<Map<String, dynamic>>? _post;
  bool _isLoading = true;
  String? _error;
  bool _isCommentSheetOpen = false;

  // 댓글 수정 모드 상태
  String? _editCommentId;
  String? _editContent;

  YoutubePlayerController? _ytController;

  @override
  void initState() {
    super.initState();
    _fetchPost();
  }

  @override
  void dispose() {
    _ytController?.dispose();
    super.dispose();
  }

  /// Firestore에서 게시글 정보 불러오기
  Future<void> _fetchPost() async {
    setState(() { _isLoading = true; });
    try {
      final doc = await FirebaseFirestore.instance.collection('posts').doc(widget.postId).get();
      if (!doc.exists) throw Exception('게시글이 존재하지 않습니다.');
      final data = doc.data();
      // 유튜브 컨트롤러 초기화
      if (data != null && data['youtubeUrl'] != null && data['youtubeUrl'] != '') {
        final videoId = YoutubePlayer.convertUrlToId(data['youtubeUrl']);
        if (videoId != null) {
          _ytController = YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(autoPlay: false),
          );
        }
      } else {
        _ytController = null;
      }
      setState(() {
        _post = doc;
        _error = null;
      });
    } catch (e) {
      setState(() { _error = '게시글을 불러오지 못했습니다.'; });
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  /// 댓글 수정 클릭 시 호출
  void _onEditComment(String commentId, String content) {
    setState(() {
      _editCommentId = commentId;
      _editContent = content;
    });
  }

  /// 댓글 수정 완료/취소 시 호출
  void _onEditDone() {
    setState(() {
      _editCommentId = null;
      _editContent = null;
    });
  }

  /// 게시글 수정/삭제 권한 확인
  bool _canEditOrDelete(Map<String, dynamic> post, String? uid, String? userType) {
    return post['authorId'] == uid || (userType == 'admin' || userType == 'developer');
  }

  /// 게시글 삭제
  Future<void> _deletePost() async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(widget.postId).delete();
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('게시글이 삭제되었습니다.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('게시글 삭제에 실패했습니다.')),
      );
    }
  }

  /// 게시글 수정 페이지로 이동 후, 수정 완료 시 상세 정보 갱신
  Future<void> _editPost() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PostEditPage(isEdit: true, postId: widget.postId),
      ),
    );
    if (result == true) {
      await _fetchPost();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('게시글이 수정되었습니다.')),
      );
    }
  }

  /// 게시글 공지 지정/해제
  Future<void> _toggleNotice(bool isNotice) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(widget.postId).update({'isNotice': !isNotice});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(!isNotice ? '공지로 지정되었습니다.' : '공지에서 해제되었습니다.')),
        );
        await _fetchPost();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('공지 변경에 실패했습니다.')),
      );
    }
  }

  void _showCommentSheet(BuildContext context) async {
    setState(() { _isCommentSheetOpen = true; });
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          expand: true,
          builder: (context, scrollController) {
            return Container(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 5,
                    margin: const EdgeInsets.only(top: 12, bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Row(
                      children: [
                        Text('댓글 ', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                        CommentCount(postId: widget.postId),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: CommentList(
                        postId: widget.postId,
                        onEdit: (id, content) {
                          setState(() {
                            _editCommentId = id;
                            _editContent = content;
                          });
                        },
                        dense: true,
                        scrollController: scrollController,
                      ),
                    ),
                  ),
                  SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 2),
                      child: CommentInput(
                        postId: widget.postId,
                        editCommentId: _editCommentId,
                        editContent: _editContent,
                        onEditDone: () {
                          setState(() {
                            _editCommentId = null;
                            _editContent = null;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
    setState(() { _isCommentSheetOpen = false; });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(_error!)),
      );
    }
    final post = _post!.data()!;
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    final userType = null; // TODO: Provider 등에서 현재 유저 타입 받아오기
    final canEditOrDelete = _canEditOrDelete(post, uid, userType);
    final isAdmin = userType == 'admin' || userType == 'developer';
    final isNotice = post['isNotice'] == true;
    // 카드와 동일한 이미지 URL 생성
    String? getYoutubeThumbnail(String? url) {
      if (url == null) return null;
      final uri = Uri.tryParse(url);
      if (uri == null || !uri.host.contains('youtu')) return null;
      final videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : null;
      if (videoId == null || videoId.length < 5) return null;
      return 'https://img.youtube.com/vi/$videoId/0.jpg';
    }
    final thumb = getYoutubeThumbnail(post['youtubeUrl']);
    final random = Random(widget.postId.hashCode);
    final picsumId = (random.nextInt(1000) + 1).toString();
    final picsumUrl = 'https://picsum.photos/seed/$picsumId/800/420';
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          // 상단 카드 확대본
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: 'postImage_${widget.postId}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.zero,
                      child: (thumb != null)
                          ? Image.network(
                              thumb,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 340,
                              loadingBuilder: (context, child, progress) => progress == null ? child : Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(color: Colors.grey[300], width: double.infinity, height: 340),
                              ),
                            )
                          : Image.network(
                              picsumUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 340,
                              loadingBuilder: (context, child, progress) => progress == null ? child : Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(color: Colors.grey[300], width: double.infinity, height: 340),
                              ),
                            ),
                    ),
                  ),
                  // 프로필/닉네임/시간
                  Positioned(
                    left: 16,
                    top: 16,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: post['authorProfileUrl'] != null && post['authorProfileUrl'] != ''
                              ? NetworkImage(post['authorProfileUrl'])
                              : const AssetImage('assets/images/default_profile.png') as ImageProvider,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          post['authorNickname'] ?? '',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14, shadows: [Shadow(color: Colors.black26, blurRadius: 2)]),
                        ),
                      ],
                    ),
                  ),
                  // 좋아요/댓글/시간
                  Positioned(
                    left: 16,
                    bottom: 16,
                    right: 16,
                    child: Row(
                      children: [
                        Icon(Icons.favorite_border, size: 18, color: Colors.white),
                        const SizedBox(width: 2),
                        Text('${post['likesCount'] ?? 0}', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white, fontSize: 13)),
                        const SizedBox(width: 8),
                        Icon(Icons.mode_comment_outlined, size: 18, color: Colors.white),
                        const SizedBox(width: 2),
                        CommentCount(postId: widget.postId),
                        const SizedBox(width: 8),
                        Text(
                          post['createdAt'] != null
                              ? _formatDate((post['createdAt'] as Timestamp).toDate())
                              : '',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70, fontSize: 12),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  // 제목(이미지 하단 중앙)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 48,
                    child: Center(
                      child: Text(
                        post['title'] ?? '',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22, shadows: [Shadow(color: Colors.black38, blurRadius: 4)]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              // 본문
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                child: Text(
                  post['content'] ?? '',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 15),
                ),
              ),
            ],
          ),
          // 댓글 바텀시트 트리거 (하단 고정)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: GestureDetector(
                onTap: () => _showCommentSheet(context),
                child: Container(
                  margin: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text('댓글 ', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      CommentCount(postId: widget.postId),
                      const Spacer(),
                      Icon(_isCommentSheetOpen ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded, size: 28, color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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