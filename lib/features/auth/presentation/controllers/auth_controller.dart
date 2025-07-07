import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/use_cases/sign_in_with_google_use_case.dart';
import '../../domain/use_cases/save_profile_use_case.dart';
import '../../domain/use_cases/check_auth_and_profile_use_case.dart';
import '../../domain/repositories/auth_repository.dart';

/// 인증 상태 관리 컨트롤러
class AuthController extends AsyncNotifier<UserEntity?> {
  late final SignInWithGoogleUseCase _signInWithGoogle;
  late final SaveProfileUseCase _saveProfile;
  late final CheckAuthAndProfileUseCase _checkAuthAndProfile;

  @override
  FutureOr<UserEntity?> build() async {
    // DI 및 초기 상태 설정
    return null;
  }

  /// 구글 로그인
  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      final user = await _signInWithGoogle();
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// 프로필 저장
  Future<void> saveProfile(UserEntity user) async {
    state = const AsyncValue.loading();
    try {
      await _saveProfile(user);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// 인증 및 프로필 체크
  Future<AuthCheckResult> checkAuthAndProfile() async {
    return await _checkAuthAndProfile();
  }
} 