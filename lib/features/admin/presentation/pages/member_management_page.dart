import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../admin_providers.dart';
import '../controllers/member_management_controller.dart';
import '../widgets/admin_user_list_tile.dart';

/// 회원관리 페이지 (클린 아키텍처/riverpod 기반)
class MemberManagementPage extends ConsumerWidget {
  const MemberManagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(memberManagementControllerProvider);
    final controller = ref.read(memberManagementControllerProvider.notifier);

    return Scaffold(
      body: state.when(
        data: (data) {
          if (data.users.isEmpty) {
            return const Center(child: Text('회원이 없습니다.'));
          }
          return ListView.separated(
            itemCount: data.users.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, idx) {
              final user = data.users[idx];
              return AdminUserListTile(
                user: user,
                onChangeType: (type) => controller.changeUserType(user.id, type),
                onRemove: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('회원 삭제'),
                      content: const Text('정말 삭제하시겠습니까?'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('취소')),
                        TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('삭제')),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    controller.removeUser(user.id);
                  }
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('에러: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.fetchUsers,
        child: const Icon(Icons.refresh),
        tooltip: '회원 목록 새로고침',
      ),
    );
  }
} 