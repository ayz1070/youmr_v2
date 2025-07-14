import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// 게시글/댓글 좋아요 버튼 위젯
///
/// - Firestore에 좋아요/취소 트랜잭션 처리
/// - Provider/DI 구조로 개선 권장
/// - 컬러/문구/패딩 등은 core/constants로 상수화 권장
class LikeButton extends StatefulWidget {
  /// 게시글/댓글 ID
  final String postId;
  /// 좋아요 UID 리스트
  final List<dynamic> likes;
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
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late bool _liked;
  late int _count;

  @override
  void initState() {
    super.initState();
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    _liked = widget.likes.contains(uid);
    _count = widget.likesCount;
  }

  /// 좋아요/취소 트랜잭션 처리
  Future<void> _toggleLike() async {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final DocumentReference ref = FirebaseFirestore.instance
        .collection(widget.isComment ? 'comments' : 'posts')
        .doc(widget.postId);
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
      await FirebaseFirestore.instance.runTransaction((tx) async {
        final snap = await tx.get(ref);
        final List<String> likes = List<String>.from(snap['likes'] ?? []);
        final int likesCount = snap['likesCount'] ?? 0;
        if (likes.contains(uid)) {
          likes.remove(uid);
          tx.update(ref, {'likes': likes, 'likesCount': likesCount - 1});
        } else {
          likes.add(uid);
          tx.update(ref, {'likes': likes, 'likesCount': likesCount + 1});
        }
      });
    } catch (e) {
      // 롤백
      setState(() {
        if (_liked) {
          _liked = false;
          _count--;
        } else {
          _liked = true;
          _count++;
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('좋아요 처리에 실패했습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(_liked ? Icons.favorite : Icons.favorite_border, color: Colors.red),
          onPressed: _toggleLike,
        ),
        Text('$_count'),
      ],
    );
  }
} 