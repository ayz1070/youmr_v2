import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:image_picker/image_picker.dart'; // 실제 적용 시 사용

/// 프로필 수정 페이지
class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
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

  /// 기존 프로필 정보 불러오기
  Future<void> _loadProfile() async {
    setState(() => _isLoading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      final data = doc.data();
      if (data != null) {
        _nicknameController.text = data['nickname'] ?? '';
        _profileImageUrl = data['profileImageUrl'] ?? '';
        _userType = data['userType'] ?? '';
        _dayOfWeek = data['dayOfWeek'] ?? '';
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// 프로필 사진 선택 (예시)
  Future<void> _pickProfileImage() async {
    // 실제 구현 시 image_picker 사용
    // final picker = ImagePicker();
    // final picked = await picker.pickImage(source: ImageSource.gallery);
    // if (picked != null) {
    //   // TODO: Firebase Storage 업로드 후 URL 저장
    //   setState(() => _profileImageUrl = picked.path);
    // }
    // 예시: 기본 이미지로 대체
    setState(() => _profileImageUrl = null);
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
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('로그인 정보 없음');
      final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
      await userDoc.update({
        'nickname': _nicknameController.text.trim(),
        'profileImageUrl': _profileImageUrl ?? '',
        'userType': _userType,
        'dayOfWeek': _userType == 'offline_member' ? _dayOfWeek : '',
      });
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
                    TextFormField(
                      controller: _nicknameController,
                      decoration: const InputDecoration(
                        labelText: '닉네임',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v == null || v.trim().isEmpty ? '닉네임을 입력해 주세요.' : null,
                    ),
                    const SizedBox(height: 24),
                    // 회원 타입 선택
                    DropdownButtonFormField<String>(
                      value: _userType,
                      decoration: const InputDecoration(
                        labelText: '회원 타입',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'admin', child: Text('관리자')),
                        DropdownMenuItem(value: 'developer', child: Text('개발자')),
                        DropdownMenuItem(value: 'offline_member', child: Text('오프라인 회원')),
                        DropdownMenuItem(value: 'member', child: Text('일반 회원')),
                      ],
                      onChanged: (v) => setState(() => _userType = v),
                      validator: (v) => v == null ? '회원 타입을 선택해 주세요.' : null,
                    ),
                    const SizedBox(height: 24),
                    // 요일 선택 (offline_member만)
                    if (_userType == 'offline_member')
                      DropdownButtonFormField<String>(
                        value: _dayOfWeek,
                        decoration: const InputDecoration(
                          labelText: '요일 선택',
                          border: OutlineInputBorder(),
                        ),
                        items: _days
                            .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                            .toList(),
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