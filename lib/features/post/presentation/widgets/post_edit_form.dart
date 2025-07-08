import 'package:flutter/material.dart';

/// 게시글 수정/작성 폼 위젯
class PostEditForm extends StatelessWidget {
  final bool isEdit;
  final String? postId;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const PostEditForm({super.key, required this.isEdit, this.postId, required this.onSave, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    // 실제 폼 UI 코드 분리 구현
    // ...
    return Container(); // TODO: 실제 UI 코드로 대체
  }
} 