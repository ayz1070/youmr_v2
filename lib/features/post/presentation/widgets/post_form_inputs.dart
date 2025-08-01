import 'package:flutter/material.dart';
import 'package:youmr_v2/core/widgets/app_text_field.dart';
import 'package:youmr_v2/core/widgets/app_dropdown.dart';
import 'package:youmr_v2/core/widgets/app_button.dart';

/// 게시글 작성 페이지의 폼 입력 필드들
class PostFormInputs extends StatelessWidget {
  final TextEditingController contentController;
  final TextEditingController youtubeController;
  final String category;
  final List<String> categories;
  final void Function(String?) onCategoryChanged;
  final VoidCallback onSubmit;
  final bool isLoading;

  const PostFormInputs({
    super.key,
    required this.contentController,
    required this.youtubeController,
    required this.category,
    required this.categories,
    required this.onCategoryChanged,
    required this.onSubmit,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 32, 18, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 내용 입력
          AppTextField(
            controller: contentController,
            labelText: '내용',
            maxLines: 6,
            validator: (v) => v == null || v.trim().isEmpty ? '내용을 입력해 주세요.' : null,
          ),
          const SizedBox(height: 16),
          
          // 카테고리 선택
          AppDropdown<String>(
            value: category,
            items: categories,
            labelText: '카테고리',
            itemTextBuilder: (category) => category,
            onChanged: onCategoryChanged,
          ),
          const SizedBox(height: 16),
          
          // 유튜브 링크 입력
          AppTextField(
            controller: youtubeController,
            labelText: '유튜브 링크(선택)',
          ),
          const SizedBox(height: 32),
          
          // 등록 버튼
          AppButton(
            text: "등록",
            onPressed: isLoading ? null : onSubmit,
          ),
        ],
      ),
    );
  }
} 