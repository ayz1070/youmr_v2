import 'package:flutter/material.dart';

import 'comment_count.dart';
import 'comment_input.dart';
import 'comment_list.dart';

class PostCommentBottomSheet extends StatelessWidget {
  final String postId;
  final String? editCommentId;
  final String? editContent;
  final void Function(String, String) onEditComment;
  final VoidCallback onEditDone;
  const PostCommentBottomSheet({super.key, required this.postId, this.editCommentId, this.editContent, required this.onEditComment, required this.onEditDone});

  @override
  Widget build(BuildContext context) {
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
                    CommentCount(postId: postId),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: CommentList(
                    postId: postId,
                    onEdit: onEditComment,
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
      },
    );
  }
}
