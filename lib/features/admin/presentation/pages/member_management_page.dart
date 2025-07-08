import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/admin_user_provider.dart';

/// 회원 관리 페이지 (Provider 기반)
class MemberManagementPage extends ConsumerWidget {
  const MemberManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userListAsync = ref.watch(adminUserProvider);
    final notifier = ref.read(adminUserProvider.notifier);

    ref.listen(adminUserProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('에러: ${next.error}')),
        );
      }
    });

    return userListAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('에러: $e')),
      data: (users) {
        if (users.isEmpty) {
          return const Center(child: Text('회원이 없습니다.'));
        }
        return ListView.separated(
          itemCount: users.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, idx) {
            final user = users[idx];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: user.profileImageUrl.isNotEmpty
                    ? NetworkImage(user.profileImageUrl)
                    : const AssetImage('assets/images/default_profile.png') as ImageProvider,
              ),
              title: Text(user.nickname),
              subtitle: Text('이메일: ${user.email}\n권한: ${user.userType}'),
              trailing: PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value.startsWith('type:')) {
                    await notifier.changeUserType(uid: user.uid, newType: value.substring(5));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('권한이 변경되었습니다.')),
                    );
                  } else if (value == 'remove') {
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
                      await notifier.removeUser(uid: user.uid);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('회원이 삭제되었습니다.')),
                      );
                    }
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'type:admin', child: Text('관리자 지정')),
                  const PopupMenuItem(value: 'type:developer', child: Text('개발자 지정')),
                  const PopupMenuItem(value: 'type:offline_member', child: Text('오프라인 회원 지정')),
                  const PopupMenuItem(value: 'type:member', child: Text('일반 회원 지정')),
                  const PopupMenuDivider(),
                  const PopupMenuItem(value: 'remove', child: Text('회원 삭제', style: TextStyle(color: Colors.red))),
                ],
              ),
            );
          },
        );
      },
    );
  }
} 