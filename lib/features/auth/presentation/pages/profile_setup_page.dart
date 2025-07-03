import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:image_picker/image_picker.dart'; // 실제 적용 시 주석 해제
import '../../../main/presentation/pages/main_navigation_page.dart';

/// 회원가입 시 프로필 정보 입력 화면
class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  String? _userType;
  String? _dayOfWeek;
  bool _isLoading = false;

  // 요일 리스트
  final List<String> _days = ['월', '화', '수', '목', '금', '토', '일'];

  /// 프로필 정보 저장
  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    if (_userType == null) {
      _showError('회원 타입을 선택해 주세요.');
      return;
    }
    if (_userType == 'offline_member' && _dayOfWeek == null) {
      _showError('요일을 선택해 주세요.');
      return;
    }
    setState(() => _isLoading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('로그인 정보 없음');
      
      // 사용자 문서 생성 또는 업데이트
      final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
      await userDoc.set({
        'uid': user.uid,
        'email': user.email,
        'nickname': _nicknameController.text.trim(),
        'profileImageUrl': '', // 기본 이미지 사용
        'userType': _userType,
        'dayOfWeek': _userType == 'offline_member' ? _dayOfWeek : '',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainNavigationPage()),
        );
      }
    } catch (e) {
      print('프로필 저장 에러: $e');
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
      appBar: AppBar(title: const Text('프로필 설정')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    // 프로필 사진 (기본 이미지만 사용)
                    Center(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: const AssetImage('assets/images/default_profile.png'),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(Icons.person, size: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Center(
                      child: Text(
                        '기본 프로필 이미지',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
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
                        hintText: '사용할 닉네임을 입력하세요',
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
                        hintText: '회원 타입을 선택하세요',
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
                    if (_userType == 'offline_member') ...[
                      DropdownButtonFormField<String>(
                        value: _dayOfWeek,
                        decoration: const InputDecoration(
                          labelText: '요일 선택',
                          border: OutlineInputBorder(),
                          hintText: '참여하는 요일을 선택하세요',
                        ),
                        items: _days
                            .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                            .toList(),
                        onChanged: (v) => setState(() => _dayOfWeek = v),
                        validator: (v) => v == null ? '요일을 선택해 주세요.' : null,
                      ),
                      const SizedBox(height: 24),
                    ],
                    // 저장 버튼
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          '프로필 저장',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
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