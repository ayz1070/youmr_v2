import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../di/profile_module.dart';
import '../../domain/entities/profile.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/app_dropdown.dart';

/// 프로필 수정 페이지 (Provider 기반)
class ProfileEditPage extends ConsumerStatefulWidget {
  const ProfileEditPage({super.key});

  @override
  ConsumerState<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends ConsumerState<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  String? _profileImageUrl;
  String? _userType;
  String? _dayOfWeek;
  bool _isLoading = false;

  final List<String> _days = ['월', '화', '수', '목', '금', '토', '일'];

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  /// Provider에서 프로필 정보 불러오기
  void _loadProfile() {
    final profile = ref.read(profileProvider);
    if (profile is AsyncData<Profile?> && profile.value != null) {
      final data = profile.value!;
      _nicknameController.text = data.nickname;
      _profileImageUrl = data.profileImageUrl;
      _userType = data.userType;
      _dayOfWeek = data.dayOfWeek;
    }
  }

  /// 프로필 사진 선택 (예시)
  Future<void> _pickProfileImage() async {
    setState(() => _profileImageUrl = null); // 실제 구현 시 image_picker 사용
  }

  /// 프로필 정보 저장
  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    if (_userType == null) {
      _showError('회원 타입을 선택해 주세요.');
      return;
    }
    if (_userType == 'offline_member' && (_dayOfWeek == null || _dayOfWeek!.isEmpty)) {
      _showError('요일을 선택해 주세요.');
      return;
    }
    setState(() => _isLoading = true);
    try {
      final notifier = ref.read(profileProvider.notifier);
      final profile = ref.read(profileProvider).value;
      if (profile == null) throw Exception('프로필 정보 없음');
      final updated = profile.copyWith(
        nickname: _nicknameController.text.trim(),
        profileImageUrl: _profileImageUrl ?? '',
        userType: _userType!,
        dayOfWeek: _userType == 'offline_member' ? _dayOfWeek : '',
      );
      await notifier.saveProfile(updated);
      if (mounted) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('프로필이 수정되었습니다.')),
        );
      }
    } catch (e) {
      _showError('프로필 저장에 실패했습니다. 다시 시도해 주세요.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('프로필 수정')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    // 프로필 사진
                    Center(
                      child: GestureDetector(
                        onTap: _pickProfileImage,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: _profileImageUrl != null && _profileImageUrl!.isNotEmpty
                              ? NetworkImage(_profileImageUrl!)
                              : const AssetImage('assets/images/default_profile.png') as ImageProvider,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(4),
                              child: const Icon(Icons.camera_alt, size: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // 닉네임 입력
                    AppTextField(
                      controller: _nicknameController,
                      labelText: '닉네임',
                      validator: (v) => v == null || v.trim().isEmpty ? '닉네임을 입력해 주세요.' : null,
                    ),
                    const SizedBox(height: 24),
                    // 회원 타입 선택
                    AppDropdown<String>(
                      value: _userType,
                      items: const ['offline_member', 'member'],
                      labelText: '회원 타입',
                      itemTextBuilder: (type) {
                        switch (type) {
                          case 'offline_member': return '오프라인 회원';
                          case 'member': return '일반 회원';
                          default: return type;
                        }
                      },
                      onChanged: (v) => setState(() => _userType = v),
                      validator: (v) => v == null ? '회원 타입을 선택해 주세요.' : null,
                    ),
                    const SizedBox(height: 24),
                    // 요일 선택 (offline_member만)
                    if (_userType == 'offline_member')
                      AppDropdown<String>(
                        value: _dayOfWeek,
                        items: _days,
                        labelText: '요일 선택',
                        itemTextBuilder: (day) => day,
                        onChanged: (v) => setState(() => _dayOfWeek = v),
                        validator: (v) => v == null ? '요일을 선택해 주세요.' : null,
                      ),
                    const SizedBox(height: 32),
                    // 저장 버튼
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveProfile,
                        child: const Text('저장'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }
} 