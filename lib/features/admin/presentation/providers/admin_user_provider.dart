import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/admin_user.dart';
import '../../domain/use_cases/get_all_users.dart';
import '../../domain/use_cases/change_user_type.dart';
import '../../domain/use_cases/remove_user.dart';
import '../../data/repositories/admin_user_repository_impl.dart';
import '../../data/data_sources/admin_user_firestore_data_source.dart';

/// 관리자/회원 목록 및 액션 Provider (AsyncNotifier)
final adminUserProvider = AsyncNotifierProvider<AdminUserNotifier, List<AdminUser>>(
  AdminUserNotifier.new,
);

class AdminUserNotifier extends AsyncNotifier<List<AdminUser>> {
  late final GetAllUsers _getAllUsers;
  late final ChangeUserType _changeUserType;
  late final RemoveUser _removeUser;

  @override
  FutureOr<List<AdminUser>> build() async {
    // DI: 실제 구현체 주입
    final repository = AdminUserRepositoryImpl(
      dataSource: AdminUserFirestoreDataSource(),
    );
    _getAllUsers = GetAllUsers(repository);
    _changeUserType = ChangeUserType(repository);
    _removeUser = RemoveUser(repository);
    // 전체 회원 목록 불러오기
    return await _getAllUsers();
  }

  /// 회원 권한 변경
  Future<void> changeUserType({required String uid, required String newType}) async {
    state = const AsyncValue.loading();
    await _changeUserType(uid: uid, newType: newType);
    state = AsyncValue.data(await _getAllUsers());
  }

  /// 회원 삭제
  Future<void> removeUser({required String uid}) async {
    state = const AsyncValue.loading();
    await _removeUser(uid: uid);
    state = AsyncValue.data(await _getAllUsers());
  }
} 