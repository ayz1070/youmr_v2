import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../widgets/comment_count.dart';
import '../widgets/comment_list.dart';
import '../widgets/comment_input.dart';
import '../widgets/like_button.dart';
import 'post_edit_page.dart';
import 'package:uuid/uuid.dart';
import '../widgets/post_card.dart';
import 'dart:math';
import 'package:shimmer/shimmer.dart';
import '../widgets/post_detail_body.dart';
import '../widgets/post_comment_section.dart';
import '../widgets/post_comment_trigger.dart';

/// 게시글 상세 + 댓글 페이지
///
/// - 상태/로직은 Provider로 분리 권장(현재는 StatefulWidget)
/// - 공통 위젯(AppLoadingView, AppErrorView 등) 사용 권장
/// - 컬러/문구/패딩 등은 core/constants로 상수화 권장
class PostDetailPage extends StatefulWidget {
  /// 상세 조회할 게시글 ID
  final String postId;

  /// 생성자
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
    setState(() {
      _isLoading = true;
    });
    try {
      final DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .get();
      if (!doc.exists) throw Exception('게시글이 존재하지 않습니다.');
      final Map<String, dynamic>? data = doc.data();
      // 유튜브 컨트롤러 초기화
      if (data != null && data['youtubeUrl'] != null && data['youtubeUrl'] != '') {
        final String? videoId = YoutubePlayer.convertUrlToId(data['youtubeUrl']);
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
      setState(() {
        _error = '게시글을 불러오지 못했습니다.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 댓글 수정 클릭 시 호출
  /// [commentId] : 수정할 댓글 ID
  /// [content] : 기존 댓글 내용
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
  /// [post] : 게시글 데이터
  /// [uid] : 현재 유저 UID
  /// [userType] : 유저 타입(admin/developer 등)
  /// return : 수정/삭제 가능 여부
  bool _canEditOrDelete(
    Map<String, dynamic> post,
    String? uid,
    String? userType,
  ) {
    return post['authorId'] == uid ||
        (userType == 'admin' || userType == 'developer');
  }

  /// 게시글 삭제
  Future<void> _deletePost() async {
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .delete();
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('게시글이 삭제되었습니다.')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('게시글 삭제에 실패했습니다.')));
    }
  }

  /// 게시글 수정 페이지로 이동 후, 수정 완료 시 상세 정보 갱신
  Future<void> _editPost() async {
    final dynamic result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PostEditPage(isEdit: true, postId: widget.postId),
      ),
    );
    if (result == true) {
      await _fetchPost();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('게시글이 수정되었습니다.')));
    }
  }

  /// 게시글 공지 지정/해제
  /// [isNotice] : 현재 공지 여부
  Future<void> _toggleNotice(bool isNotice) async {
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .update({'isNotice': !isNotice});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(!isNotice ? '공지로 지정되었습니다.' : '공지에서 해제되었습니다.')),
        );
        await _fetchPost();
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('공지 변경에 실패했습니다.')));
    }
  }

  /// 댓글 입력 바텀시트 표시
  /// [context] : 빌드 컨텍스트
  void _showCommentSheet(BuildContext context) async {
    setState(() {
      _isCommentSheetOpen = true;
    });
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Text(
                          '댓글 ',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
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
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        bottom: 8,
                        top: 2,
                      ),
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
    setState(() {
      _isCommentSheetOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(

        ),
        body: Center(child: Text(_error!)),
      );
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: PostDetailBody(
              post: _post,
              ytController: _ytController,
              isLoading: _isLoading,
              error: _error,
            ),
          ),
          // 댓글 바텀시트 트리거 (하단 고정)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: PostCommentTrigger(
              postId: widget.postId,
              isOpen: _isCommentSheetOpen,
              onTap: () => _showCommentSheet(context),
            ),
          ),
        ],
      ),
    );
  }
}
