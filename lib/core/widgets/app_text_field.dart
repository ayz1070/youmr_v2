import 'package:flutter/material.dart';

/// 커스텀 텍스트 필드 위젯
/// 이미지 스타일의 디자인을 적용한 텍스트 필드
class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool enabled;
  final int? maxLines;

  const AppTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.enabled = true,
    this.maxLines,
  });

  /// 이미지 스타일의 InputDecoration 생성 함수
  InputDecoration _getImageStyleDecoration(String labelText, {String? hintText}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Color(0xFF666666),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Color(0xFFCCCCCC),
        fontSize: 16,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: _getImageStyleDecoration(labelText, hintText: hintText),
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType,
      enabled: enabled,
      maxLines: maxLines,
    );
  }
} 