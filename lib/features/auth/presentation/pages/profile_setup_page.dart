import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../widgets/profile_image_picker.dart';
import '../widgets/profile_form.dart';
import '../../../../core/constants/profile_setup_constants.dart';
import '../../../../core/utils/profile_setup_utils.dart';
import '../../../../core/utils/onboarding_utils.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../main/presentation/pages/main_navigation_page.dart';
import 'onboarding_page.dart';
import '../../../../core/widgets/app_button.dart';

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
  final TextEditingController _nameController = TextEditingController();
  String? _userType;
  String? _dayOfWeek;
  File? _selectedImageFile;
  String? _currentImageUrl;
  bool _isImageUploading = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  /// 현재 유저 정보 로드
  void _loadCurrentUser() {
    final authState = ref.read(authProvider);
    if (authState.value != null) {
      _nicknameController.text = authState.value!.nickname;
      _nameController.text = authState.value!.name ?? '';
      _currentImageUrl = authState.value!.profileImageUrl;
    }
  }

  /// 이미지 선택 콜백
  void _onImageSelected(File imageFile) {
    setState(() {
      _selectedImageFile = imageFile;
    });
  }

  /// 이미지 선택 에러 콜백
  void _onImageError(String error) {
    ProfileSetupUtils.showError(context, error);
  }

  /// 회원 타입 변경 콜백
  void _onUserTypeChanged(String? userType) {
    setState(() {
      _userType = userType;
      // 오프라인 회원이 아닌 경우 요일 초기화
      if (userType != ProfileSetupConstants.offlineMember) {
        _dayOfWeek = null;
      }
    });
  }

  /// 요일 변경 콜백
  void _onDayOfWeekChanged(String? dayOfWeek) {
    setState(() {
      _dayOfWeek = dayOfWeek;
    });
  }

  /// 프로필 저장 요청
  Future<void> _onSaveProfile() async {
    // 폼 유효성 검사
    if (!ProfileSetupUtils.validateForm(_formKey, _userType, _dayOfWeek, context)) {
      return;
    }

    final user = ref.read(authProvider).value;
    if (user == null) {
      ProfileSetupUtils.showError(context, ProfileSetupConstants.loginInfoNotFound);
      return;
    }

    // 이미지 업로드 처리
    String? finalImageUrl = await _uploadImageIfNeeded();
    if (finalImageUrl == null && _selectedImageFile != null) {
      return; // 이미지 업로드 실패
    }

    // 프로필 정보 업데이트
    final updatedUser = user.copyWith(
      nickname: _nicknameController.text.trim(),
      name: _nameController.text.trim().isEmpty ? null : _nameController.text.trim(),
      userType: _userType,
      dayOfWeek: _userType == ProfileSetupConstants.offlineMember ? _dayOfWeek : '',
      profileImageUrl: finalImageUrl ?? _currentImageUrl,
    );

    ref.read(authProvider.notifier).saveProfile(updatedUser);
  }

  /// 이미지 업로드 처리 (필요한 경우)
  /// 반환: 업로드된 이미지 URL 또는 null
  Future<String?> _uploadImageIfNeeded() async {
    if (_selectedImageFile == null) return null;

    setState(() {
      _isImageUploading = true;
    });

    try {
      final uploadedImageUrl = await ref.read(authProvider.notifier).uploadProfileImage(_selectedImageFile!);
      if (uploadedImageUrl != null) {
        if (mounted) {
          ProfileSetupUtils.showSuccess(context, "회원가입 되었습니다");
        }
        return uploadedImageUrl;
      } else {
        if (mounted) {
          ProfileSetupUtils.showError(context, ProfileSetupConstants.imageUploadFailed);
        }
        return null;
      }
    } catch (e) {
      if (mounted) {
        ProfileSetupUtils.showError(context, '${ProfileSetupConstants.imageUploadError}$e');
      }
      return null;
    } finally {
      if (mounted) {
        setState(() {
          _isImageUploading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 인증 상태 구독
    final authState = ref.watch(authProvider);
    
    // 상태 변화 리스너: 저장 성공/실패 분기
    ref.listen(authProvider, (previous, next) {
      // 저장 성공 시 온보딩 여부 확인 후 분기
      if (previous?.isLoading == true && next is AsyncData) {
        // async 작업을 별도 함수로 분리하여 BuildContext 문제 해결
        _handleProfileSaveSuccess();
      }
      // 에러 발생 시 스낵바 표시
      if (next is AsyncError) {
        final error = next.error;
        if (context.mounted) {
          AppSnackbar.showError(context, '${ProfileSetupConstants.profileSaveFailed}${error.toString()}');
        }
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text(ProfileSetupConstants.pageTitle)),
      body: authState.isLoading || _isImageUploading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: ListView(
                children: [
                  // 프로필 이미지 선택 위젯
                  ProfileImagePicker(
                    selectedImageFile: _selectedImageFile,
                    currentImageUrl: _currentImageUrl,
                    onImageSelected: _onImageSelected,
                    onError: _onImageError,
                  ),
                  const SizedBox(height: 24),
                  // 프로필 폼 위젯
                  ProfileForm(
                    formKey: _formKey,
                    nicknameController: _nicknameController,
                    nameController: _nameController,
                    userType: _userType,
                    dayOfWeek: _dayOfWeek,
                    onUserTypeChanged: _onUserTypeChanged,
                    onDayOfWeekChanged: _onDayOfWeekChanged,
                  ),
                  // 저장 버튼
                  AppButton(
                    text: ProfileSetupConstants.confirmButton,
                    onPressed: authState.isLoading || _isImageUploading ? null : _onSaveProfile,
                  ),
                ],
              ),
            ),
    );
  }

  /// 프로필 저장 성공 처리
  Future<void> _handleProfileSaveSuccess() async {
    // 온보딩 완료 여부 확인
    final isOnboardingCompleted = await OnboardingUtils.isOnboardingCompleted();
    
    if (mounted) {
      if (isOnboardingCompleted) {
        // 온보딩 완료된 경우 메인 페이지로 이동
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainNavigationPage()),
        );
      } else {
        // 온보딩이 필요한 경우 온보딩 페이지로 이동
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const OnboardingPage()),
        );
      }
    }
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
