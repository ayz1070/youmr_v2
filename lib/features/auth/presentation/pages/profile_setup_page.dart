import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/empty_state.dart';
import '../controllers/auth_controller.dart';
import '../../../main/presentation/pages/main_navigation_page.dart';
import '../../domain/entities/user_entity.dart';

/// 회원가입 시 프로필 정보 입력 화면 (Riverpod 기반)
class ProfileSetupPage extends ConsumerStatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  ConsumerState<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends ConsumerState<ProfileSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  String? _userType;
  String? _dayOfWeek;
  final List<String> _days = ['월', '화', '수', '목', '금', '토', '일'];

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final authController = ref.read(authControllerProvider.notifier);

    ref.listen(authControllerProvider, (prev, next) {
      next.whenOrNull(
        data: (user) {
          if (user != null && context.mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const MainNavigationPage()),
            );
          }
        },
        error: (e, st) {
          if (context.mounted) {
            _showError('프로필 저장 실패: ${e.toString()}');
          }
        },
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text('프로필 설정')),
      body: authState.isLoading
          ? const LoadingIndicator()
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
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;
                          if (_userType == null) {
                            _showError('회원 타입을 선택해 주세요.');
                            return;
                          }
                          if (_userType == 'offline_member' && _dayOfWeek == null) {
                            _showError('요일을 선택해 주세요.');
                            return;
                          }
                          final user = UserEntity(
                            uid: '', // 실제 로그인 유저의 uid로 대체 필요
                            email: '', // 실제 로그인 유저의 email로 대체 필요
                            nickname: _nicknameController.text.trim(),
                            profileImageUrl: '',
                            userType: _userType!,
                            dayOfWeek: _userType == 'offline_member' ? _dayOfWeek : '',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          );
                          authController.saveProfile(user);
                        },
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
} 