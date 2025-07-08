import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/use_cases/sign_in_with_google.dart';
import '../../domain/use_cases/sign_out.dart';
import '../../domain/use_cases/get_current_user.dart';
import '../../domain/use_cases/save_profile.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/data_sources/auth_firebase_data_source.dart';

/// 인증 상태 관리 Provider (AsyncNotifier)
final authProvider = AsyncNotifierProvider<AuthNotifier, AuthUser?>(
  AuthNotifier.new,
);

class AuthNotifier extends AsyncNotifier<AuthUser?> {
  late final SignInWithGoogle _signInWithGoogle;
  late final SignOut _signOut;
  late final GetCurrentUser _getCurrentUser;
  late final SaveProfile _saveProfile;

  @override
  FutureOr<AuthUser?> build() async {
    // DI: 실제 구현체 주입
    final repository = AuthRepositoryImpl(
      dataSource: AuthFirebaseDataSource(),
    );
    _signInWithGoogle = SignInWithGoogle(repository);
    _signOut = SignOut(repository);
    _getCurrentUser = GetCurrentUser(repository);
    _saveProfile = SaveProfile(repository);

    // 현재 로그인 유저 정보 불러오기
    final result = await _getCurrentUser();
    return result.fold(
      (failure) => throw AsyncError(failure, StackTrace.current),
      (user) => user,
    );
  }

  /// 구글 로그인
  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    final result = await _signInWithGoogle();
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (user) => state = AsyncValue.data(user),
    );
  }

  /// 로그아웃
  Future<void> signOut() async {
    state = const AsyncValue.loading();
    final result = await _signOut();
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) => state = const AsyncValue.data(null),
    );
  }

  /// 프로필 저장
  Future<void> saveProfile(AuthUser user) async {
    state = const AsyncValue.loading();
    final result = await _saveProfile(user: user);
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) async {
        // 저장 후 최신 정보 다시 불러오기
        final newResult = await _getCurrentUser();
        newResult.fold(
          (failure) => state = AsyncValue.error(failure, StackTrace.current),
          (user) => state = AsyncValue.data(user),
        );
      },
    );
  }
} 