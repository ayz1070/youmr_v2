import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../di/comment_module.dart';
import 'comment_item.dart';

/// 댓글의 수정/삭제/신고 콜백 타입
typedef OnEditComment = void Function(String commentId, String content);

/// 게시글의 댓글 리스트 위젯
///
/// - Provider를 통한 댓글 실시간 조회
/// - 컬러/문구/패딩 등은 core/constants로 상수화 권장
class CommentList extends ConsumerWidget {
  /// 게시글 ID
  final String postId;
  /// 댓글 수정 콜백
  final OnEditComment? onEdit;
  /// 리스트 뷰 밀집 여부
  final bool dense;
  /// 외부 스크롤 컨트롤러
  final ScrollController? scrollController;
  /// 생성자
  const CommentList({
    super.key, 
    required this.postId, 
    this.onEdit, 
    this.dense = false, 
    this.scrollController,
  });

  /// 관리자/작성자 권한 확인
  /// [comment] : 댓글 엔티티
  /// [uid] : 현재 유저 UID
  /// [userType] : 유저 타입
  /// return : 수정/삭제 가능 여부
  bool _isAdminOrOwner(comment, String? uid, String? userType) {
    return comment.authorId == uid || (userType == 'admin' || userType == 'developer');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uid = user?.uid;
    // 관리자 권한 확인(간단 예시)
    final userType = null; // TODO: Provider 등에서 현재 유저 타입 받아오기

    final commentState = ref.watch(commentProvider(postId));

    if (commentState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (commentState.error != null) {
      return Center(child: Text('오류가 발생했습니다: ${commentState.error}'));
    }

    if (commentState.comments.isEmpty) {
      return const Center(child: Text('댓글이 없습니다.'));
    }

    return ListView.separated(
      controller: scrollController,
      itemCount: commentState.comments.length,
      separatorBuilder: (_, __) => Divider(height: 0),
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(), // 스크롤 가능하도록 변경
      itemBuilder: (context, idx) {
        final comment = commentState.comments[idx];
        final bool isOwnerOrAdmin = _isAdminOrOwner(comment, uid, userType);
        
        return CommentItem(
          key: ValueKey('${comment.id}_${comment.content}_${comment.likeCount}'), // 더 구체적인 키로 변경
          comment: comment,
          isOwnerOrAdmin: isOwnerOrAdmin,
          uid: uid,
          userType: userType,
          onEdit: onEdit,
        );
      },
    );
  }
}

