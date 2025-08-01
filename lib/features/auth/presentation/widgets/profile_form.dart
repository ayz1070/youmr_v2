import 'package:flutter/material.dart';

/// 프로필 폼 위젯
/// - 닉네임, 회원 타입, 요일 선택 폼
class ProfileForm extends StatelessWidget {
  /// 폼 키
  final GlobalKey<FormState> formKey;
  /// 닉네임 컨트롤러
  final TextEditingController nicknameController;
  /// 선택된 회원 타입
  final String? userType;
  /// 선택된 요일
  final String? dayOfWeek;
  /// 회원 타입 변경 콜백
  final Function(String?) onUserTypeChanged;
  /// 요일 변경 콜백
  final Function(String?) onDayOfWeekChanged;

  /// [formKey]: 폼 키
  /// [nicknameController]: 닉네임 컨트롤러
  /// [userType]: 선택된 회원 타입
  /// [dayOfWeek]: 선택된 요일
  /// [onUserTypeChanged]: 회원 타입 변경 콜백
  /// [onDayOfWeekChanged]: 요일 변경 콜백
  const ProfileForm({
    super.key,
    required this.formKey,
    required this.nicknameController,
    this.userType,
    this.dayOfWeek,
    required this.onUserTypeChanged,
    required this.onDayOfWeekChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          // 닉네임 입력
          TextFormField(
            controller: nicknameController,
            decoration: const InputDecoration(
              labelText: '닉네임',
              border: OutlineInputBorder(),
              hintText: '닉네임을 입력하세요',
            ),
            validator: (v) => v == null || v.trim().isEmpty
                ? '닉네임을 입력하세요'
                : null,
          ),
          const SizedBox(height: 24),
          // 회원 타입 선택
          DropdownButtonFormField<String>(
            value: userType,
            decoration: const InputDecoration(
              labelText: '회원 유형',
              border: OutlineInputBorder(),
              hintText: '여민락 회원은 오프라인 회원 선택',
            ),
            items: const [
              DropdownMenuItem(
                value: 'offline_member',
                child: Text('오프라인 회원'),
              ),
              DropdownMenuItem(value: 'member', child: Text('온라인 회원')),
            ],
            onChanged: onUserTypeChanged,
            validator: (v) => v == null ? '회원 타입을 선택해 주세요.' : null,
          ),
          const SizedBox(height: 24),
          // 요일 선택 (offline_member만)
          if (userType == 'offline_member') ...[
            _buildDayOfWeekDropdown(),
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }

  /// 요일 선택 드롭다운 위젯
  Widget _buildDayOfWeekDropdown() {
    const List<String> days = ['월', '화', '수', '목', '금', '토', '일'];
    
    return DropdownButtonFormField<String>(
      value: dayOfWeek,
      decoration: const InputDecoration(
        labelText: '요일 선택',
        border: OutlineInputBorder(),
        hintText: '참여하는 요일을 선택하세요',
      ),
      items: days
          .map((d) => DropdownMenuItem(value: d, child: Text(d)))
          .toList(),
      onChanged: onDayOfWeekChanged,
      validator: (v) => v == null ? '요일을 선택해 주세요.' : null,
    );
  }
} 