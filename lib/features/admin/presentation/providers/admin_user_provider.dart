import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/admin_user.dart';
import '../../domain/use_cases/get_all_users.dart';
import '../../domain/use_cases/change_user_type.dart';
import '../../domain/use_cases/remove_user.dart';

/// 관리자/회원 목록 및 액션 Provider (AsyncNotifier)
final adminUserProvider = AsyncNotifierProvider<AdminUserNotifier, List<AdminUser>>(
  AdminUserNotifier.new,
);

/// 관리자/회원 AsyncNotifier
class AdminUserNotifier extends AsyncNotifier<List<AdminUser>> {
  /// 전체 회원 조회 유즈케이스
  late final GetAllUsers _getAllUsers;
  /// 회원 권한 변경 유즈케이스
  late final ChangeUserType _changeUserType;
  /// 회원 삭제 유즈케이스
  late final RemoveUser _removeUser;

  /// 생성자(의존성 외부 주입)
  AdminUserNotifier({
    GetAllUsers? getAllUsers,
    ChangeUserType? changeUserType,
    RemoveUser? removeUser,
  }) {
    _getAllUsers = getAllUsers ?? ref.read(getAllUsersProvider);
    _changeUserType = changeUserType ?? ref.read(changeUserTypeProvider);
    _removeUser = removeUser ?? ref.read(removeUserProvider);
  }

  @override
  FutureOr<List<AdminUser>> build() async {
    // 전체 회원 목록 불러오기 (Either 처리)
    final result = await _getAllUsers();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (users) => users,
    );
  }

  /// 회원 권한 변경
  /// [uid] : 회원 UID
  /// [newType] : 변경할 권한 타입
  Future<void> changeUserType({required String uid, required String newType}) async {
    state = const AsyncValue.loading();
    final result = await _changeUserType(uid: uid, newType: newType);
    await result.fold(
      (failure) async => state = AsyncValue.error(failure.message, StackTrace.current),
      (_) async => await _refreshUsers(),
    );
  }

  /// 회원 삭제
  /// [uid] : 회원 UID
  Future<void> removeUser({required String uid}) async {
    state = const AsyncValue.loading();
    final result = await _removeUser(uid: uid);
    await result.fold(
      (failure) async => state = AsyncValue.error(failure.message, StackTrace.current),
      (_) async => await _refreshUsers(),
    );
  }

  /// 회원 목록 새로고침 (내부 전용)
  Future<void> _refreshUsers() async {
    final usersResult = await _getAllUsers();
    state = usersResult.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (users) => AsyncValue.data(users),
    );
  }
}

/// Provider DI: UseCase별 Provider 정의(테스트/Mock 주입 용이)
final getAllUsersProvider = Provider<GetAllUsers>((ref) => throw UnimplementedError());
final changeUserTypeProvider = Provider<ChangeUserType>((ref) => throw UnimplementedError());
final removeUserProvider = Provider<RemoveUser>((ref) => throw UnimplementedError()); 