import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../di/post_detail_module.dart';
import 'comment_count.dart';
import 'comment_list.dart';
import 'comment_input.dart';

/// 댓글 바텀시트 위젯
class PostCommentBottomSheet extends ConsumerWidget {
  final String postId;
  final String? editCommentId;
  final String? editContent;
  final Function(String, String) onEdit;
  final VoidCallback onEditDone;

  const PostCommentBottomSheet({
    super.key,
    required this.postId,
    this.editCommentId,
    this.editContent,
    required this.onEdit,
    required this.onEditDone,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          // 드래그 핸들
          Container(
            width: 40,
            height: 5,
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          // 댓글 헤더
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
                CommentCount(postId: postId),
              ],
            ),
          ),
          // 댓글 목록
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CommentList(
                postId: postId,
                onEdit: onEdit,
                dense: true,
              ),
            ),
          ),
          // 댓글 입력 - Consumer로 감싸서 상태 변경 시에만 리빌드
          Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(postDetailProvider(postId));
              return Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  bottom: 8,
                  top: 2,
                ),
                child: CommentInput(
                  postId: postId,
                  editCommentId: state.editCommentId,
                  editContent: state.editContent,
                  onEditDone: () {
                    ref.read(postDetailProvider(postId).notifier).clearEditComment();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// 댓글 바텀시트 표시 함수
Future<void> showPostCommentBottomSheet(
  BuildContext context,
  WidgetRef ref,
  String postId,
) async {
  final notifier = ref.read(postDetailProvider(postId).notifier);
  
  notifier.toggleCommentSheet(true);
  
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    enableDrag: true,
    builder: (ctx) {
      return DraggableScrollableSheet(
        initialChildSize: 0.7, // 초기 높이 70%
        minChildSize: 0.5, // 최소 높이 50%
        maxChildSize: 0.9, // 최대 높이 90%
        builder: (context, scrollController) {
          return Consumer(
            builder: (context, ref, child) {
              // 키보드 높이 감지
              final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
              final state = ref.watch(postDetailProvider(postId));
              
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                ),
                child: Column(
                  children: [
                    // 드래그 핸들
                    Container(
                      width: 40,
                      height: 5,
                      margin: const EdgeInsets.only(top: 12, bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    // 댓글 헤더
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
                          CommentCount(postId: postId),
                        ],
                      ),
                    ),
                    // 댓글 목록 (키보드 높이에 따라 조정)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: CommentList(
                          postId: postId,
                          onEdit: (id, content) {
                            ref.read(postDetailProvider(postId).notifier).setEditComment(id, content);
                          },
                          dense: true,
                          scrollController: scrollController,
                        ),
                      ),
                    ),
                    // 댓글 입력 (키보드 상단에 붙어서 올라옴)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 1), // 부드러운 애니메이션
                      curve: Curves.easeInOut,
                      padding: EdgeInsets.only(
                        left: 12,
                        right: 12,
                        bottom: 8 + keyboardHeight, // 키보드 높이만큼 추가 패딩
                        top: 2,
                      ),
                      child: CommentInput(
                        postId: postId,
                        editCommentId: state.editCommentId,
                        editContent: state.editContent,
                        onEditDone: () {
                          ref.read(postDetailProvider(postId).notifier).clearEditComment();
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    },
  );
  
  notifier.toggleCommentSheet(false);
}
