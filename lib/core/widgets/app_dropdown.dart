import 'package:flutter/material.dart';

/// 커스텀 드롭다운 위젯
/// AppTextField와 동일한 디자인을 적용한 드롭다운
class AppDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String labelText;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged;
  final String Function(T) itemTextBuilder;
  final bool enabled;

  const AppDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.labelText,
    required this.itemTextBuilder,
    this.validator,
    this.onChanged,
    this.enabled = true,
  });

  /// AppTextField와 동일한 스타일의 InputDecoration 생성 함수
  InputDecoration _getImageStyleDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Color(0xFF666666),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      filled: true,
      fillColor: const Color(0xFFF5F5F5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide.none,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      suffixIcon: const Icon(
        Icons.arrow_drop_down,
        color: Color(0xFF666666),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items.map((item) => DropdownMenuItem<T>(
        value: item,
        child: Text(
          itemTextBuilder(item),
          style: const TextStyle(
            color: Color(0xFF333333),
            fontSize: 16,
          ),
        ),
      )).toList(),
      onChanged: enabled ? onChanged : null,
      decoration: _getImageStyleDecoration(labelText),
      validator: validator,
      icon: const SizedBox.shrink(), // 기본 아이콘 제거 (suffixIcon 사용)
      dropdownColor: const Color(0xFFF5F5F5),
      style: const TextStyle(
        color: Color(0xFF333333),
        fontSize: 16,
      ),
    );
  }
} 