import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../di/comment_module.dart';

/// 댓글 입력창 위젯 (수정 모드 지원)
///
/// - Provider를 통한 댓글 등록/수정
/// - 키보드와 독립적으로 동작
/// - 컬러/문구/패딩 등은 core/constants로 상수화 권장
class CommentInput extends ConsumerStatefulWidget {
  /// 게시글 ID
  final String postId;
  /// 수정할 댓글 ID(수정 모드)
  final String? editCommentId;
  /// 수정할 댓글 내용(수정 모드)
  final String? editContent;
  /// 수정 완료/취소 콜백
  final VoidCallback? onEditDone;
  /// 생성자
  const CommentInput({
    super.key,
    required this.postId,
    this.editCommentId,
    this.editContent,
    this.onEditDone,
  });

  @override
  ConsumerState<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends ConsumerState<CommentInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // 초기 수정 모드 확인
    if (widget.editCommentId != null && widget.editContent != null) {
      _controller.text = widget.editContent!;
    }
  }

  @override
  void didUpdateWidget(covariant CommentInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 수정 모드 진입 시 기존 내용 입력
    if (widget.editCommentId != null && widget.editCommentId != oldWidget.editCommentId) {
      _controller.text = widget.editContent ?? '';
      // 수정 모드 진입 시 자동으로 포커스
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _focusNode.requestFocus();
        }
      });
    }
    // 수정 모드 종료 시 입력창 초기화
    if (widget.editCommentId == null && oldWidget.editCommentId != null) {
      _controller.clear();
      _focusNode.unfocus();
    }
  }

  /// 댓글 등록/수정 처리
  Future<void> _submit() async {
    final String text = _controller.text.trim();
    if (text.isEmpty) return;
    
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('로그인 필요');
      
      // 사용자 정보 조회
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final userData = userDoc.data() ?? {};
      final nickname = userData['nickname'] ?? '';
      final profileUrl = userData['profileImageUrl'];
      
      final commentNotifier = ref.read(commentProvider(widget.postId).notifier);
      
      if (widget.editCommentId != null) {
        // 댓글 수정
        final result = await commentNotifier.updateComment(
          commentId: widget.editCommentId!,
          content: text,
        );
        
        result.fold(
          (failure) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('댓글 수정에 실패했습니다: ${failure.message}')),
              );
            }
          },
          (_) {
            if (widget.onEditDone != null) widget.onEditDone!();
          },
        );
      } else {
        // 새 댓글 등록
        final result = await commentNotifier.createComment(
          content: text,
          authorNickname: nickname,
          authorProfileUrl: profileUrl,
        );
        
        result.fold(
          (failure) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('댓글 등록에 실패했습니다: ${failure.message}')),
              );
            }
          },
          (_) {
            _controller.clear();
            _focusNode.unfocus();
          },
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('댓글 등록/수정에 실패했습니다. 다시 시도해 주세요.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final commentState = ref.watch(commentProvider(widget.postId));
    final bool isEdit = widget.editCommentId != null;
    final ThemeData theme = Theme.of(context);
    
    return Container(
      color: theme.colorScheme.surfaceContainerLowest,
      padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                style: theme.textTheme.bodySmall,
                decoration: InputDecoration(
                  hintText: isEdit ? '댓글을 수정하세요...' : '댓글을 입력하세요...',
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
                minLines: 1,
                maxLines: 3, // 최대 3줄까지 허용
                enabled: !commentState.isLoading,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _submit(),
                onTap: () {
                  // 텍스트 필드 터치 시 포커스만 요청 (상태 변경 없음)
                  if (!_focusNode.hasFocus) {
                    _focusNode.requestFocus();
                  }
                },
                onChanged: (value) {
                  // 텍스트 변경 시에도 상태 변경 없음
                },
                onEditingComplete: () {
                  // 편집 완료 시에도 상태 변경 없음
                },
              ),
            ),
          ),
          if (isEdit)
            TextButton(
              onPressed: commentState.isLoading
                  ? null
                  : () {
                      _controller.clear();
                      _focusNode.unfocus();
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
              onPressed: commentState.isLoading ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                minimumSize: const Size(36, 36),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: 0,
              ),
              child: commentState.isLoading
                  ? SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: theme.colorScheme.onPrimary))
                  : Icon(isEdit ? Icons.check : Icons.send, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
} 