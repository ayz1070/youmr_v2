import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentCount extends StatelessWidget {
  final String postId;

  const CommentCount({required this.postId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('comments')
          .where('postId', isEqualTo: postId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        final count = snapshot.data!.docs.length;
        return Text(
          '$count',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        );
      },
    );
  }
}
