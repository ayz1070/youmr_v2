import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/profile.dart';
import '../presentation/providers/notifiers/profile_notifier.dart';

/// 프로필 상태 관리 Provider (AsyncNotifier)
final profileProvider = AsyncNotifierProvider<ProfileNotifier, Profile?>(
  ProfileNotifier.new,
);
