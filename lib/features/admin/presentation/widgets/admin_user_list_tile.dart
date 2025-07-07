import 'package:flutter/material.dart';
import '../../domain/entities/admin_user_entity.dart';

/// 관리자 유저 리스트 타일 위젯
class AdminUserListTile extends StatelessWidget {
  final AdminUserEntity user;
  final ValueChanged<String> onChangeType;
  final VoidCallback onRemove;
  const AdminUserListTile({Key? key, required this.user, required this.onChangeType, required this.onRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: user.profileImageUrl.isNotEmpty
            ? NetworkImage(user.profileImageUrl)
            : const AssetImage('assets/images/default_profile.png') as ImageProvider,
      ),
      title: Text(user.nickname),
      subtitle: Text('이메일: ${user.email}\n권한: ${user.userType}'),
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          if (value.startsWith('type:')) {
            onChangeType(value.substring(5));
          } else if (value == 'remove') {
            onRemove();
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
  }
} 