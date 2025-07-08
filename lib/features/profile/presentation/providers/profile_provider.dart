import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/profile.dart';
import '../../domain/use_cases/get_my_profile.dart';
import '../../domain/use_cases/save_my_profile.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../data/data_sources/profile_firestore_data_source.dart';
import '../../core/errors/profile_failure.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// 프로필 상태 관리 Provider (AsyncNotifier)
final profileProvider = AsyncNotifierProvider<ProfileNotifier, Profile?>(
  ProfileNotifier.new,
);

class ProfileNotifier extends AsyncNotifier<Profile?> {
  late final GetMyProfile _getMyProfile;
  late final SaveMyProfile _saveMyProfile;

  @override
  FutureOr<Profile?> build() async {
    // DI: 실제 구현체 주입
    final repository = ProfileRepositoryImpl(
      dataSource: ProfileFirestoreDataSource(),
    );
    _getMyProfile = GetMyProfile(repository);
    _saveMyProfile = SaveMyProfile(repository);

    // 현재 로그인 유저 정보로 프로필 불러오기
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    final result = await _getMyProfile(uid: user.uid);
    return result.fold(
      (failure) => throw AsyncError(failure, StackTrace.current),
      (profile) => profile,
    );
  }

  /// 프로필 정보 저장
  Future<void> saveProfile(Profile profile) async {
    state = const AsyncValue.loading();
    final result = await _saveMyProfile(profile: profile);
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) async {
        // 저장 후 최신 정보 다시 불러오기
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) return;
        final newResult = await _getMyProfile(uid: user.uid);
        newResult.fold(
          (failure) => state = AsyncValue.error(failure, StackTrace.current),
          (profile) => state = AsyncValue.data(profile),
        );
      },
    );
  }

  /// 로그아웃 기능
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }
} 