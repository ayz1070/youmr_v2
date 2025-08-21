import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../di/post_detail_module.dart';
import '../providers/states/post_detail_state.dart';
import '../widgets/post_detail_body.dart';
import '../widgets/post_comment_trigger.dart';
import '../widgets/post_comment_bottom_sheet.dart';
import '../../../../core/widgets/app_loading_view.dart';
import '../../../../core/widgets/app_error_view.dart';
import 'post_edit_page.dart';

/// 게시글 상세 + 댓글 페이지
///
/// - Riverpod을 사용한 상태 관리
/// - 공통 위젯(AppLoadingView, AppErrorView 등) 사용
/// - 비즈니스 로직은 PostDetailNotifier로 분리
class PostDetailPage extends ConsumerWidget {
  /// 상세 조회할 게시글 ID
  final String postId;

  /// 생성자
  const PostDetailPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postDetailProvider(postId));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // 본인이 작성한 게시글인 경우에만 수정/삭제 메뉴 표시
          if (state.post != null)
            FutureBuilder<bool>(
              future: ref.read(postDetailProvider(postId).notifier).canEditOrDelete(state.post!),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data == true) {
                  return PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    color: Theme.of(context).colorScheme.surface,
                    onSelected: (value) => _handleMenuAction(context, ref, value),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 18, color: Colors.black),
                            SizedBox(width: 8),
                            Text('수정'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 18, color: Colors.black),
                            SizedBox(width: 8),
                            Text('삭제', style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
        ],
      ),
      body: Stack(
        children: [
          // 메인 콘텐츠
          Positioned.fill(child: _buildBody(context, ref, state)),
          // 댓글 바텀시트 트리거 (하단 고정)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: PostCommentTrigger(
              postId: postId,
              isOpen: state.isCommentSheetOpen,
              onTap: () => _showCommentSheet(context, ref),
            ),
          ),
        ],
      ),
    );
  }

  /// 메인 콘텐츠 빌드
  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    PostDetailState state,
  ) {
    if (state.isLoading) {
      return const AppLoadingView();
    }

    if (state.error != null) {
      return AppErrorView(
        message: state.error!,
        onRetry: () {
          ref.read(postDetailProvider(postId).notifier).fetchPost(postId);
        },
      );
    }

    return PostDetailBody(
      post: state.post,
      ytController: state.ytController,
      isLoading: state.isLoading,
      error: state.error,
    );
  }

  /// 댓글 바텀시트 표시
  void _showCommentSheet(BuildContext context, WidgetRef ref) {
    showPostCommentBottomSheet(context, ref, postId);
  }

  /// 메뉴 액션 처리
  void _handleMenuAction(BuildContext context, WidgetRef ref, String action) {
    switch (action) {
      case 'edit':
        _navigateToEditPage(context, ref);
        break;
      case 'delete':
        _showDeleteDialog(context, ref);
        break;
    }
  }

  /// 수정 페이지로 이동
  void _navigateToEditPage(BuildContext context, WidgetRef ref) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (_) => PostEditPage(isEdit: true, postId: postId),
          ),
        )
        .then((result) {
          // 수정 페이지에서 돌아온 후 게시글 데이터 새로고침
          if (result == true) {
            // 수정이 성공적으로 완료된 경우에만 새로고침
            // PostDetailProvider의 fetchPost 메서드 호출하여 데이터 새로고침
            if (context.mounted) {
              ref.read(postDetailProvider(postId).notifier).fetchPost(postId);
            }
          }
        });
  }

  /// 삭제 확인 다이얼로그 표시
  void _showDeleteDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: '게시글 삭제',
        message: "정말로 이 게시글을 삭제하시겠습니까?\n삭제된 게시글은 복구할 수 없습니다.",
        onConfirm: () => Navigator.of(context).pop(),
        onCancel: () async {
          Navigator.of(context).pop();
          await _deletePost(context, ref);
        },

      ),
    );
  }

  /// 게시글 삭제 실행
  Future<void> _deletePost(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(postDetailProvider(postId).notifier).deletePost(postId);

      if (context.mounted) {
        // 삭제 성공 시 이전 페이지로 이동
        Navigator.of(context).pop();

        // 성공 메시지 표시
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('게시글이 삭제되었습니다.')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('삭제에 실패했습니다: ${e.toString()}')));
      }
    }
  }
}
