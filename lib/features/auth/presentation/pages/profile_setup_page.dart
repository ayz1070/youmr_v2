import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../../../main/presentation/pages/main_navigation_page.dart';

/// 회원가입 시 프로필 정보 입력 화면 (Provider 기반)
class ProfileSetupPage extends ConsumerStatefulWidget {
  /// [key]: 위젯 고유 키
  const ProfileSetupPage({super.key});

  @override
  ConsumerState<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

/// 프로필 설정 페이지 상태 클래스
class _ProfileSetupPageState extends ConsumerState<ProfileSetupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nicknameController = TextEditingController();
  String? _userType;
  String? _dayOfWeek;

  // 요일 리스트
  final List<String> _days = ['월', '화', '수', '목', '금', '토', '일'];

  /// 에러 메시지 스낵바 표시 (실제 앱에서는 AppErrorView 등 공통 위젯 사용 권장)
  /// [message]: 에러 메시지
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)), // 문구 상수화 권장
    );
  }

  /// 프로필 저장 요청
  void _onSaveProfile() {
    if (!_formKey.currentState!.validate()) return;
    if (_userType == null) {
      _showError('회원 타입을 선택해 주세요.'); // 문구 상수화 권장
      return;
    }
    if (_userType == 'offline_member' && _dayOfWeek == null) {
      _showError('요일을 선택해 주세요.'); // 문구 상수화 권장
      return;
    }
    final user = ref.read(authProvider).value;
    if (user == null) {
      _showError('로그인 정보가 없습니다.'); // 문구 상수화 권장
      return;
    }
    final updatedUser = user.copyWith(
      nickname: _nicknameController.text.trim(),
      userType: _userType,
      dayOfWeek: _userType == 'offline_member' ? _dayOfWeek : '',
    );
    ref.read(authProvider.notifier).saveProfile(updatedUser);
  }

  @override
  Widget build(BuildContext context) {
    // 인증 상태 구독
    final authState = ref.watch(authProvider);
    // 상태 변화 리스너: 저장 성공/실패 분기
    ref.listen(authProvider, (previous, next) {
      // 저장 성공 시 메인 페이지로 이동
      if (previous?.isLoading == true && next is AsyncData) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainNavigationPage()),
        );
      }
      // 에러 발생 시 스낵바 표시 (실제 앱에서는 AppErrorView 등 공통 위젯 사용 권장)
      if (next is AsyncError) {
        final error = next.error;
        _showError('프로필 저장 실패: ${error.toString()}'); // 문구 상수화 권장
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('프로필 설정')), // 문구 상수화 권장
      body: authState.isLoading
          // 로딩 상태: CircularProgressIndicator 대신 AppLoadingView 등 공통 위젯 사용 권장
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
                        '기본 프로필 이미지', // 문구 상수화 권장
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
                        labelText: '닉네임', // 문구 상수화 권장
                        border: OutlineInputBorder(),
                        hintText: '사용할 닉네임을 입력하세요', // 문구 상수화 권장
                      ),
                      validator: (v) => v == null || v.trim().isEmpty ? '닉네임을 입력해 주세요.' : null, // 문구 상수화 권장
                    ),
                    const SizedBox(height: 24),
                    // 회원 타입 선택
                    DropdownButtonFormField<String>(
                      value: _userType,
                      decoration: const InputDecoration(
                        labelText: '회원 타입', // 문구 상수화 권장
                        border: OutlineInputBorder(),
                        hintText: '회원 타입을 선택하세요', // 문구 상수화 권장
                      ),
                      items: const [
                        DropdownMenuItem(value: 'admin', child: Text('관리자')),
                        DropdownMenuItem(value: 'developer', child: Text('개발자')),
                        DropdownMenuItem(value: 'offline_member', child: Text('오프라인 회원')),
                        DropdownMenuItem(value: 'member', child: Text('일반 회원')),
                      ],
                      onChanged: (v) => setState(() => _userType = v),
                      validator: (v) => v == null ? '회원 타입을 선택해 주세요.' : null, // 문구 상수화 권장
                    ),
                    const SizedBox(height: 24),
                    // 요일 선택 (offline_member만)
                    if (_userType == 'offline_member') ...[
                      DropdownButtonFormField<String>(
                        value: _dayOfWeek,
                        decoration: const InputDecoration(
                          labelText: '요일 선택', // 문구 상수화 권장
                          border: OutlineInputBorder(),
                          hintText: '참여하는 요일을 선택하세요', // 문구 상수화 권장
                        ),
                        items: _days
                            .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                            .toList(),
                        onChanged: (v) => setState(() => _dayOfWeek = v),
                        validator: (v) => v == null ? '요일을 선택해 주세요.' : null, // 문구 상수화 권장
                      ),
                      const SizedBox(height: 24),
                    ],
                    // 저장 버튼
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: authState.isLoading ? null : _onSaveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          '프로필 저장', // 문구 상수화 권장
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