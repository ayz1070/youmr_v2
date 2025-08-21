import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../di/comment_module.dart';
import '../../di/post_detail_module.dart';

/// 게시글/댓글 좋아요 버튼 위젯 (이미지 디자인 기반)
///
/// - Provider를 통한 좋아요/취소 처리
/// - 간단한 하트 아이콘과 숫자 표시
/// - 컬러/문구/패딩 등은 core/constants로 상수화 권장
class LikeButton extends ConsumerStatefulWidget {
  /// 게시글/댓글 ID
  final String postId;
  /// 좋아요 UID 리스트
  final List<String> likes;
  /// 좋아요 수
  final int likeCount;
  /// 댓글 여부(true면 댓글, false면 게시글)
  final bool isComment;
  /// 생성자
  const LikeButton({
    super.key,
    required this.postId,
    required this.likes,
    required this.likeCount,
    this.isComment = false,
  });

  @override
  ConsumerState<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends ConsumerState<LikeButton> {
  late bool _liked;
  late int _count;

  @override
  void initState() {
    super.initState();
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    _liked = widget.likes.contains(uid);
    _count = widget.likeCount;
  }

  /// 좋아요/취소 처리
  Future<void> _toggleLike() async {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    // 현재 상태 저장 (복원용)
    final originalLiked = _liked;
    final originalCount = _count;

    // UI 즉시 업데이트 (낙관적 업데이트)
    setState(() {
      _liked = !_liked;  // 현재 상태를 반대로 토글
      if (_liked) {
        _count++;
      } else {
        _count--;
      }
    });

    try {
      if (widget.isComment) {
        // 댓글 좋아요 처리
        final commentNotifier = ref.read(commentProvider(widget.postId).notifier);
        final result = await commentNotifier.toggleLike(widget.postId);
        
        result.fold(
          (failure) {
            // 실패 시 롤백
            setState(() {
              _liked = originalLiked;
              _count = originalCount;
            });
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('좋아요 처리에 실패했습니다: ${failure.message}')),
              );
            }
          },
          (_) {
            // 성공 시 아무것도 하지 않음 (이미 UI 업데이트됨)
          },
        );
      } else {
        // 게시글 좋아요 처리
        final toggleLike = ref.read(toggleLikeProvider);
        final result = await toggleLike(
          postId: widget.postId,
          userId: uid,
          isLiked: originalLiked, // 원래 상태 전달 (낙관적 업데이트 전 상태)
        );
        
        result.fold(
          (failure) {
            // 실패 시 롤백
            setState(() {
              _liked = originalLiked;
              _count = originalCount;
            });
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('좋아요 처리에 실패했습니다: ${failure.message}')),
              );
            }
          },
          (newLikeStatus) {
            // 성공 시 서버 응답으로 상태 업데이트
            setState(() {
              _liked = newLikeStatus;
              // 서버 응답에 맞게 카운트 조정
              if (newLikeStatus != originalLiked) { // 상태가 실제로 변경된 경우에만
                if (newLikeStatus) {
                  _count = originalCount + 1;
                } else {
                  _count = originalCount - 1;
                }
              }
            });
          },
        );
      }
    } catch (e) {
      // 실패 시 롤백
      setState(() {
        _liked = originalLiked;
        _count = originalCount;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('좋아요 처리에 실패했습니다.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleLike,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _liked ? Icons.favorite : Icons.favorite_border,
            size: 16, // 16 -> 18
            color: _liked ? Colors.red : Colors.grey.shade500,
          ),
          const SizedBox(width: 2),
          Text(
            '$_count',
            style: TextStyle(
              fontSize: 12, // 12 -> 14
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
} 