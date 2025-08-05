import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../providers/comment_provider.dart';

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
  final int likesCount;
  /// 댓글 여부(true면 댓글, false면 게시글)
  final bool isComment;
  /// 생성자
  const LikeButton({
    super.key,
    required this.postId,
    required this.likes,
    required this.likesCount,
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
    _count = widget.likesCount;
  }

  /// 좋아요/취소 처리
  Future<void> _toggleLike() async {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    // UI 즉시 업데이트 (낙관적 업데이트)
    setState(() {
      if (_liked) {
        _liked = false;
        _count--;
      } else {
        _liked = true;
        _count++;
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
              if (_liked) {
                _liked = false;
                _count--;
              } else {
                _liked = true;
                _count++;
              }
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
        // 게시글 좋아요 처리 (기존 로직 유지)
        // TODO: 게시글 좋아요 Provider 구현 후 교체
        throw UnimplementedError('게시글 좋아요는 아직 구현되지 않았습니다.');
      }
    } catch (e) {
      // 실패 시 롤백
      setState(() {
        if (_liked) {
          _liked = false;
          _count--;
        } else {
          _liked = true;
          _count++;
        }
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