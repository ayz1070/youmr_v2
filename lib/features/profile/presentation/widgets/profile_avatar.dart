import 'package:flutter/material.dart';

/// 프로필 아바타 위젯
class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  const ProfileAvatar({Key? key, this.imageUrl, this.radius = 40}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: (imageUrl != null && imageUrl!.isNotEmpty)
          ? NetworkImage(imageUrl!)
          : const AssetImage('assets/images/default_profile.png') as ImageProvider,
      child: (imageUrl == null || imageUrl!.isEmpty)
          ? const Icon(Icons.person, size: 40, color: Colors.grey)
          : null,
    );
  }
} 