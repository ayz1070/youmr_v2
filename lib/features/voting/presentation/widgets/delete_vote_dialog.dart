import 'package:flutter/material.dart';

import '../../../../core/widgets/app_dialog.dart';

/// 곡 삭제 확인 다이얼로그
class DeleteVoteDialog extends StatelessWidget {
  /// 곡 제목
  final String songTitle;

  /// 삭제 확인 콜백
  final VoidCallback? onConfirm;

  const DeleteVoteDialog({
    super.key,
    required this.songTitle,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: '곡 삭제',
      message: '$songTitle 을(를) 삭제하시겠습니까?',
      cancelText: '취소',
      confirmText: '삭제',
      confirmColor: Colors.black, // 빨간색 (삭제 액션)
      onConfirm: onConfirm,
    );
  }
}
