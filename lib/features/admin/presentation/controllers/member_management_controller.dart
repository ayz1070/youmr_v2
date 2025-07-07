import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/admin_user_entity.dart';
import '../../domain/use_cases/fetch_admin_users_use_case.dart';
import '../../domain/use_cases/change_user_type_use_case.dart';
import '../../domain/use_cases/remove_user_use_case.dart';

part 'member_management_controller.freezed.dart';
// part 'member_management_controller.g.dart'; // 삭제된 파일 import 제거

/// 회원관리 상태
@freezed
class MemberManagementState with _$MemberManagementState {
  const factory MemberManagementState({
    @Default([]) List<AdminUserEntity> users,
    @Default(false) bool isLoading,
    String? error,
  }) = _MemberManagementState;
}

/// 회원관리 컨트롤러 (AsyncNotifier)
class MemberManagementController extends AsyncNotifier<MemberManagementState> {
  late final FetchAdminUsersUseCase _fetchUsersUseCase;
  late final ChangeUserTypeUseCase _changeUserTypeUseCase;
  late final RemoveUserUseCase _removeUserUseCase;

  @override
  Future<MemberManagementState> build() async {
    // DI: 유스케이스 주입 (provider에서 처리)
    return const MemberManagementState();
  }

  /// 유저 목록 조회
  Future<void> fetchUsers() async {
    state = const AsyncLoading();
    try {
      final users = await _fetchUsersUseCase();
      state = AsyncData(MemberManagementState(users: users));
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  /// 유저 권한 변경
  Future<void> changeUserType(String uid, String newType) async {
    try {
      await _changeUserTypeUseCase(uid, newType);
      await fetchUsers();
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  /// 유저 삭제
  Future<void> removeUser(String uid) async {
    try {
      await _removeUserUseCase(uid);
      await fetchUsers();
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
} 