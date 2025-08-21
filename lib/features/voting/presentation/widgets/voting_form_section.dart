import 'package:flutter/material.dart';
import '../../../../core/widgets/app_text_field.dart';

/// 투표 등록 폼 섹션 위젯
/// 제목, 가수, YouTube 링크 입력 필드들을 포함
class VotingFormSection extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController artistController;
  final TextEditingController youtubeController;
  final GlobalKey<FormState> formKey;

  const VotingFormSection({
    super.key,
    required this.titleController,
    required this.artistController,
    required this.youtubeController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          // 제목 입력
          AppTextField(
            controller: titleController,
            labelText: '제목',
            hintText: '곡 제목을 입력해주세요 (ex 사건의 지평선)',
            validator: (value) =>
                (value == null || value.trim().isEmpty) ? '제목을 입력해 주세요.' : null,
          ),
          const SizedBox(height: 24),
          // 가수 입력
          AppTextField(
            controller: artistController,
            labelText: '가수',
            hintText: '가수명을 입력해주세요 (ex 윤하)',
            validator: (value) =>
                (value == null || value.trim().isEmpty) ? '가수를 입력해 주세요.' : null,
          ),
          const SizedBox(height: 24),
          // YouTube 링크 입력
          AppTextField(
            controller: youtubeController,
            labelText: 'YouTube 링크 (선택)',
            hintText: 'YouTube 링크를 입력해주세요 (ex www.youtube.com...)',
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
} 