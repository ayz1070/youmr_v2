import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:youmr_v2/features/voting/presentation/widgets/delete_vote_dialog.dart';

/// 공통 다이얼로그 위젯
class AppDialog extends StatelessWidget {
  /// 다이얼로그 제목
  final String title;
  
  /// 다이얼로그 메시지
  final String message;
  
  /// 취소 버튼 텍스트
  final String? cancelText;
  
  /// 확인 버튼 텍스트
  final String? confirmText;
  
  /// 취소 버튼 색상
  final Color? cancelColor;
  
  /// 확인 버튼 색상
  final Color? confirmColor;
  
  /// 취소 버튼 텍스트 색상
  final Color? cancelTextColor;
  
  /// 확인 버튼 텍스트 색상
  final Color? confirmTextColor;
  
  /// 취소 버튼 클릭 시 콜백
  final VoidCallback? onCancel;
  
  /// 확인 버튼 클릭 시 콜백
  final VoidCallback? onConfirm;
  
  /// 취소 버튼 표시 여부
  final bool showCancelButton;
  
  /// 확인 버튼 표시 여부
  final bool showConfirmButton;

  const AppDialog({
    super.key,
    required this.title,
    required this.message,
    this.cancelText = '취소',
    this.confirmText = '확인',
    this.cancelColor = const Color(0xFFF5F5F5),
    this.confirmColor = Colors.black,
    this.cancelTextColor = Colors.black,
    this.confirmTextColor = Colors.white,
    this.onCancel,
    this.onConfirm,
    this.showCancelButton = true,
    this.showConfirmButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 제목
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // 메시지
            Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.4,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 48),
            // 버튼 영역
            Row(
              children: [
                // 취소 버튼
                if (showCancelButton)
                  Expanded(
                    child: _buildButton(
                      text: cancelText!,
                      backgroundColor: cancelColor!,
                      textColor: cancelTextColor!,
                      onPressed: onCancel ?? () => Navigator.of(context).pop(false),
                    ),
                  ),

                // 확인 버튼
                if (showConfirmButton)
                  Expanded(
                    child: _buildButton(
                      text: confirmText!,
                      backgroundColor: confirmColor!,
                      textColor: confirmTextColor!,
                      onPressed: onConfirm ?? () => Navigator.of(context).pop(true),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 버튼 위젯 생성
  Widget _buildButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ),
    );
  }
}



/// 다이얼로그 표시 헬퍼 함수들
class AppDialogHelper {
  /// 기본 확인 다이얼로그 표시
  static Future<bool?> showConfirmDialog({
    required BuildContext context,
    required String title,
    required String message,
    String? cancelText,
    String? confirmText,
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AppDialog(
        title: title,
        message: message,
        cancelText: cancelText,
        confirmText: confirmText,
        onCancel: onCancel,
        onConfirm: onConfirm,
      ),
    );
  }

  /// 곡 삭제 확인 다이얼로그 표시
  static Future<bool?> showDeleteVoteDialog({
    required BuildContext context,
    required String songTitle,
    VoidCallback? onConfirm,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => DeleteVoteDialog(
        songTitle: songTitle,
        onConfirm: onConfirm,
      ),
    );
  }
} 