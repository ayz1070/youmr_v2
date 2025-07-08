import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'post_card.dart';

/// 공지 리스트 위젯
class PostNoticeList extends StatelessWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> notices;
  final ThemeData theme;
  const PostNoticeList({super.key, required this.notices, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: notices.map((noticeDoc) {
        final notice = noticeDoc.data();
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Card(
            elevation: 3,
            color: theme.colorScheme.primaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(
                color: theme.colorScheme.primary.withOpacity(0.18),
                width: 1.2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.campaign,
                      color: theme.colorScheme.onPrimary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: PostCard(
                      postId: noticeDoc.id,
                      title: '[공지] ${notice['title'] ?? ''}',
                      content: notice['content'] ?? '',
                      author: notice['authorNickname'] ?? '',
                      authorProfileUrl: notice['authorProfileUrl'] ?? '',
                      createdAt: notice['createdAt'] != null ? (notice['createdAt'] as Timestamp).toDate() : null,
                      youtubeUrl: notice['youtubeUrl'],
                      likes: notice['likes'] ?? [],
                      likesCount: notice['likesCount'] ?? 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
} 