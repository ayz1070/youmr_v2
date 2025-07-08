import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// 댓글 입력창 위젯 (수정 모드 지원)
class CommentInput extends StatefulWidget {
  final String postId;
  final String? editCommentId;
  final String? editContent;
  final VoidCallback? onEditDone;
  const CommentInput({
    super.key,
    required this.postId,
    this.editCommentId,
    this.editContent,
    this.onEditDone,
  });

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  final _controller = TextEditingController();
  bool _isLoading = false;

  @override
  void didUpdateWidget(covariant CommentInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 수정 모드 진입 시 기존 내용 입력
    if (widget.editCommentId != null && widget.editCommentId != oldWidget.editCommentId) {
      _controller.text = widget.editContent ?? '';
    }
    // 수정 모드 종료 시 입력창 초기화
    if (widget.editCommentId == null && oldWidget.editCommentId != null) {
      _controller.clear();
    }
  }

  Future<void> _submit() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() => _isLoading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('로그인 필요');
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      final userData = userDoc.data() ?? {};
      if (widget.editCommentId != null) {
        // 댓글 수정
        await FirebaseFirestore.instance.collection('comments').doc(widget.editCommentId).update({
          'content': text,
        });
        if (widget.onEditDone != null) widget.onEditDone!();
      } else {
        // 새 댓글 등록
        await FirebaseFirestore.instance.collection('comments').add({
          'postId': widget.postId,
          'content': text,
          'authorId': user.uid,
          'authorNickname': userData['nickname'] ?? '',
          'authorProfileUrl': userData['profileImageUrl'] ?? '',
          'likes': [],
          'likesCount': 0,
          'createdAt': Timestamp.fromDate(DateTime.now()),
          'serverCreatedAt': FieldValue.serverTimestamp(),
        });
      }
      _controller.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('댓글 등록/수정에 실패했습니다. 다시 시도해 주세요.')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.editCommentId != null;
    final theme = Theme.of(context);
    return SafeArea(
      child: Container(
        color: theme.colorScheme.surfaceContainerLowest,
        padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                child: TextField(
                  controller: _controller,
                  style: theme.textTheme.bodySmall,
                  decoration: InputDecoration(
                    hintText: isEdit ? '댓글을 수정하세요...' : '댓글을 입력하세요...',
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  minLines: 1,
                  maxLines: 2,
                  enabled: !_isLoading,
                ),
              ),
            ),
            if (isEdit)
              TextButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        _controller.clear();
                        if (widget.onEditDone != null) widget.onEditDone!();
                      },
                style: TextButton.styleFrom(
                  minimumSize: const Size(36, 36),
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textStyle: theme.textTheme.bodySmall,
                ),
                child: const Text('취소'),
              ),
            const SizedBox(width: 4),
            SizedBox(
              height: 36,
              width: 36,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  minimumSize: const Size(36, 36),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  elevation: 0,
                ),
                child: _isLoading
                    ? SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: theme.colorScheme.onPrimary))
                    : Icon(isEdit ? Icons.check : Icons.send, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
} 