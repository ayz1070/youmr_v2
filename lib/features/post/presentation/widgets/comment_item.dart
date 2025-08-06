import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youmr_v2/features/post/domain/entities/comment.dart';
import 'comment_list.dart';
import 'like_button.dart';
import '../providers/comment_provider.dart';

/// 개별 댓글 아이템 위젯 (이미지 디자인 기반)
class CommentItem extends ConsumerWidget {
  final Comment comment;
  final bool isOwnerOrAdmin;
  final String? uid;
  final String? userType;
  final OnEditComment? onEdit;

  const CommentItem({
    super.key,
    required this.comment,
    required this.isOwnerOrAdmin,
    required this.uid,
    required this.userType,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 행: 프로필 + 액션 버튼
          Row(
            children: [
              // 프로필 섹션 (왼쪽)
              Expanded(
                child: Row(
                  children: [
                    // 프로필 이미지
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: comment.authorProfileUrl != null && comment.authorProfileUrl!.isNotEmpty
                          ? ClipOval(
                              child: Image.network(
                                comment.authorProfileUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => _buildProfileText(),
                              ),
                            )
                          : _buildProfileText(),
                    ),
                    const SizedBox(width: 8),
                    // 사용자명
                    Text(
                      comment.authorNickname,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              // 액션 버튼 (오른쪽)
              if (isOwnerOrAdmin) ...[
                TextButton(
                  onPressed: () {
                    if (onEdit != null) {
                      onEdit!(comment.id, comment.content);
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(32, 24),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    '수정',
                    style: TextStyle(
                      fontSize:  10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  color: Colors.grey.shade300,
                ),
                TextButton(
                  onPressed: () async {
                    final commentNotifier = ref.read(commentProvider(comment.postId).notifier);
                    final result = await commentNotifier.deleteComment(comment.id);
                    result.fold(
                      (failure) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('댓글 삭제에 실패했습니다: ${failure.message}')),
                          );
                        }
                      },
                      (_) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('댓글이 삭제되었습니다.')),
                          );
                        }
                      },
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(32, 24),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    '삭제',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ] else ...[
                // 신고 버튼 (관리자가 아닌 경우)
                TextButton(
                  onPressed: () async {
                    final commentNotifier = ref.read(commentProvider(comment.postId).notifier);
                    final result = await commentNotifier.reportComment(
                      commentId: comment.id,
                      reason: '부적절한 댓글',
                    );
                    
                    result.fold(
                      (failure) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('신고 처리에 실패했습니다: ${failure.message}')),
                          );
                        }
                      },
                      (_) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('신고가 접수되었습니다. 관리자 검토 후 조치됩니다.')),
                          );
                        }
                      },
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(32, 24),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    '신고',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ],
          ),
          
          const SizedBox(height: 8),
          
          // 댓글 내용
          Padding(
            padding: EdgeInsets.only(left: 40),
            child: Text(
              comment.content,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade800,
                height: 1.4,
              ),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // 하단 행: 메타데이터 + 상호작용 요소
          Padding(
            padding: EdgeInsets.only(left: 40),
            child: Row(
              children: [
                // 메타데이터 (왼쪽)
                Expanded(
                  child: Row(
                    children: [
                      // 날짜
                      Text(
                        _formatDate(comment.createdAt),
                        style: TextStyle(
                          fontSize: 12 ,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // 태그 (예시)
                    ],
                  ),
                ),
                // 상호작용 요소 (오른쪽)
                Row(
                  children: [
                    const SizedBox(width: 12),
                    // 좋아요 버튼
                    LikeButton(
                      postId: comment.id,
                      likes: comment.likes,
                      likesCount: comment.likesCount,
                      isComment: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 프로필 텍스트 위젯 생성
  Widget _buildProfileText() {
    final initials = comment.authorNickname.isNotEmpty 
        ? comment.authorNickname.substring(0, 1).toUpperCase()
        : 'U';
    
    return Center(
      child: Text(
        initials,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }

  /// 날짜 포맷팅
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return '오늘';
    } else if (difference.inDays == 1) {
      return '어제';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else {
      return '${date.month}월 ${date.day}일';
    }
  }
} 