import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/use_cases/fetch_profile_use_case.dart';
import '../../domain/use_cases/update_profile_use_case.dart';

part 'profile_controller.freezed.dart';
// part 'profile_controller.g.dart'; // 삭제된 파일 import 제거

/// 프로필 상태
@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    ProfileEntity? profile,
    @Default(false) bool isLoading,
    String? error,
  }) = _ProfileState;
}

/// 프로필 컨트롤러 (AsyncNotifier)
class ProfileController extends AsyncNotifier<ProfileState> {
  late final FetchProfileUseCase _fetchProfileUseCase;
  late final UpdateProfileUseCase _updateProfileUseCase;

  @override
  Future<ProfileState> build() async {
    // DI: 유스케이스 주입 (provider에서 처리)
    return const ProfileState();
  }

  /// 내 프로필 조회
  Future<void> fetchProfile() async {
    state = const AsyncLoading();
    try {
      final profile = await _fetchProfileUseCase();
      state = AsyncData(ProfileState(profile: profile));
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  /// 내 프로필 수정
  Future<void> updateProfile(ProfileEntity profile) async {
    try {
      await _updateProfileUseCase(profile);
      await fetchProfile();
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
} 