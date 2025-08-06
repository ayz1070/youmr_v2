import 'package:flutter/material.dart';

/// 알림 설정용 커스텀 스위치 위젯
class NotificationSwitch extends StatelessWidget {
  /// 스위치 값
  final bool value;
  
  /// 값 변경 콜백
  final ValueChanged<bool>? onChanged;
  
  /// 비활성화 여부
  final bool disabled;

  const NotificationSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: disabled ? null : onChanged,
      activeColor: Theme.of(context).primaryColor,
      activeTrackColor: Theme.of(context).primaryColor.withOpacity(0.3),
      inactiveThumbColor: disabled 
          ? Colors.grey.shade400 
          : Colors.grey.shade600,
      inactiveTrackColor: disabled 
          ? Colors.grey.shade200 
          : Colors.grey.shade300,
    );
  }
}