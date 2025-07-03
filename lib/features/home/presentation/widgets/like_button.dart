import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// 게시글/댓글 좋아요 버튼 위젯
class LikeButton extends StatefulWidget {
  final String postId;
  final List<dynamic> likes;
  final int likesCount;
  final bool isComment; // true면 댓글, false면 게시글
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
    final uid = FirebaseAuth.instance.currentUser?.uid;
    _liked = widget.likes.contains(uid);
    _count = widget.likesCount;
  }

  Future<void> _toggleLike() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final ref = FirebaseFirestore.instance
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
        final likes = List<String>.from(snap['likes'] ?? []);
        final likesCount = snap['likesCount'] ?? 0;
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
        SnackBar(content: Text('좋아요 처리에 실패했습니다.')),
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