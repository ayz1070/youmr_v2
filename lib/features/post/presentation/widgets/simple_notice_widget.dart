import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../di/post_module.dart';
import '../pages/post_detail_page.dart';

/// 심플한 공지글 위젯 (최신 공지글 하나만 표시)
///
/// - 검색바와 유사한 디자인으로 게시글 상단에 표시
/// - 알림 아이콘과 함께 제목, 내용을 한 줄로 표시
/// - 클릭 시 공지글 상세 페이지로 이동
class SimpleNoticeWidget extends ConsumerWidget {
  const SimpleNoticeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noticeState = ref.watch(latestNoticeProvider);
    
    // 공지글이 없으면 표시하지 않음
    if (noticeState.notice == null) {
      return const SizedBox.shrink();
    }

    final notice = noticeState.notice!;
    final title = notice.title;
    final content = notice.content;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PostDetailPage(postId: notice.id),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(0),

            ),
            child: Row(
              children: [
                // 알림 아이콘
                Icon(
                  Icons.campaign,
                  color: Colors.black,
                  size: 20,
                ),
                const SizedBox(width: 12),
                // 제목과 내용
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 제목 (한 줄)
                      Text(
                        title.isNotEmpty ? title : '공지사항',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // 내용 (한 줄)
                      if (content.isNotEmpty)
                        Text(
                          content,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                // 화살표 아이콘
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey[400],
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 