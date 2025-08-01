import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/post_detail_body.dart';
import '../widgets/post_comment_trigger.dart';
import '../widgets/post_comment_bottom_sheet.dart';
import '../providers/post_detail_provider.dart';
import '../../../../core/widgets/app_loading_view.dart';
import '../../../../core/widgets/app_error_view.dart';

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
      ),
      body: Stack(
        children: [
          // 메인 콘텐츠
          Positioned.fill(
            child: _buildBody(context, ref, state),
          ),
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
  Widget _buildBody(BuildContext context, WidgetRef ref, PostDetailState state) {
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
}
