import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/error_messages.dart';
import '../../../../core/widgets/app_empty_view.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loading_view.dart';
import '../providers/admin_user_provider.dart';

/// 회원 관리 페이지 (Provider 기반)
class MemberManagementPage extends ConsumerWidget {
  /// 생성자
  const MemberManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 관리자/회원 목록 상태
    final AsyncValue<List<dynamic>> userListAsync = ref.watch(adminUserProvider);
    // 관리자/회원 액션 Notifier
    final AdminUserNotifier notifier = ref.read(adminUserProvider.notifier);

    // 에러 발생 시 스낵바 노출
    ref.listen(adminUserProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${ErrorMessages.commonError}: ${next.error}')),
        );
      }
    });

    // 상태별 분기 렌더링
    return userListAsync.when(
      loading: () => const AppLoadingView(),
      error: (e, st) => AppErrorView(message: ErrorMessages.commonError, errorDetail: e.toString()),
      data: (users) {
        if (users.isEmpty) {
          return const AppEmptyView(message: '회원이 없습니다.');
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
                // 접근성: 프로필 이미지 대체 텍스트
                foregroundImage: user.profileImageUrl.isNotEmpty ? null : null,
              ),
              title: Text(
                user.nickname, 
                semanticsLabel: '닉네임: ${user.nickname}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (user.name != null && user.name!.isNotEmpty)
                    Text('이름: ${user.name}', style: const TextStyle(fontSize: 12)),
                  Text('이메일: ${user.email}', style: const TextStyle(fontSize: 12)),
                  Text(
                    '권한: ${user.userType}', 
                    style: TextStyle(
                      fontSize: 12, 
                      color: _getUserTypeColor(user.userType),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              trailing: PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value.startsWith('type:')) {
                    await notifier.changeUserType(uid: user.uid, newType: value.substring(5));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('권한이 변경되었습니다.')),
                    );
                  } else if (value == 'remove') {
                    final bool? confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('회원 삭제'),
                        content: const Text('정말 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('취소')),
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, true), 
                            child: const Text('삭제', style: TextStyle(color: Colors.red))
                          ),
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
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'type:admin', child: Text('관리자 지정')),
                  PopupMenuItem(value: 'type:developer', child: Text('개발자 지정')),
                  PopupMenuItem(value: 'type:offline_member', child: Text('오프라인 회원 지정')),
                  PopupMenuItem(value: 'type:member', child: Text('일반 회원 지정')),
                  PopupMenuDivider(),
                  PopupMenuItem(value: 'remove', child: Text('회원 삭제', style: TextStyle(color: Colors.red))),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// 사용자 타입에 따른 색상 반환
  Color _getUserTypeColor(String userType) {
    switch (userType) {
      case 'admin':
        return Colors.red;
      case 'developer':
        return Colors.orange;
      case 'offline_member':
        return Colors.blue;
      case 'member':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
} 