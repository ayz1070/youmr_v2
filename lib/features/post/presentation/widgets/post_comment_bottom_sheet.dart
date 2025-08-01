import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'comment_count.dart';
import 'comment_list.dart';
import 'comment_input.dart';
import '../providers/post_detail_provider.dart';

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
          // 댓글 입력
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
                postId: postId,
                editCommentId: editCommentId,
                editContent: editContent,
                onEditDone: onEditDone,
              ),
            ),
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
    builder: (ctx) {
      return DraggableScrollableSheet(
        initialChildSize: 0.65,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        expand: true,
        builder: (context, scrollController) {
          return Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(postDetailProvider(postId));
              
              return PostCommentBottomSheet(
                postId: postId,
                editCommentId: state.editCommentId,
                editContent: state.editContent,
                onEdit: (id, content) {
                  ref.read(postDetailProvider(postId).notifier).setEditComment(id, content);
                },
                onEditDone: () {
                  ref.read(postDetailProvider(postId).notifier).clearEditComment();
                },
              );
            },
          );
        },
      );
    },
  );
  
  notifier.toggleCommentSheet(false);
}
