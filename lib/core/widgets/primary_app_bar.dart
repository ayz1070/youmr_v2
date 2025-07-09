import 'package:flutter/material.dart';

/// 앱 전역에서 사용하는 기본 AppBar 위젯
/// - title: 필수(Widget, 다국어/스타일 확장성)
/// - actions: 오른쪽 액션 위젯 리스트(선택)
/// - leading: 왼쪽 위젯(선택)
/// - backgroundColor, elevation 등 스타일 확장성
class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// AppBar 타이틀(필수, Widget)
  final Widget title;
  /// 오른쪽 액션 위젯 리스트(선택)
  final List<Widget>? actions;
  /// 왼쪽 leading 위젯(선택)
  final Widget? leading;
  /// AppBar 배경색(선택)
  final Color? backgroundColor;
  /// AppBar 그림자 높이(선택)
  final double? elevation;

  const PrimaryAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.elevation,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      centerTitle: true,
      actions: actions,
      leading: leading,
      backgroundColor: backgroundColor,
      elevation: elevation,
    );
  }
} 