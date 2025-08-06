import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youmr_v2/core/widgets/primary_app_bar.dart';
import 'package:youmr_v2/features/notification/presentation/providers/notification_provider.dart';
import 'package:youmr_v2/features/notification/presentation/widgets/notification_switch.dart';

/// 알림 설정 페이지
class NotificationSettingsPage extends ConsumerStatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  ConsumerState<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends ConsumerState<NotificationSettingsPage> {
  @override
  void initState() {
    super.initState();
    // 페이지 로드 시 알림 설정 조회
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationProvider.notifier).loadNotificationSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notificationState = ref.watch(notificationProvider);

    return Scaffold(
      appBar: const PrimaryAppBar(
        title: '알림 설정',
        showBackButton: true,
      ),
      body: notificationState.settings.when(
        data: (settings) => _buildSettingsContent(settings),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('오류가 발생했습니다: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(notificationProvider.notifier).loadNotificationSettings();
                },
                child: const Text('다시 시도'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsContent(settings) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 전체 알림 설정
        Card(
          child: ListTile(
            title: const Text('전체 알림'),
            subtitle: const Text('모든 알림을 켜거나 끕니다'),
            trailing: NotificationSwitch(
              value: settings.isEnabled,
              onChanged: (value) {
                ref.read(notificationProvider.notifier).updateNotificationSettings(
                  settings.copyWith(isEnabled: value),
                );
              },
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // 출석 체크 알림 설정
        Card(
          child: Column(
            children: [
              ListTile(
                title: const Text('출석 체크 알림'),
                subtitle: const Text('매주 지정된 요일과 시간에 출석 체크 알림을 받습니다'),
                trailing: NotificationSwitch(
                  value: settings.attendanceReminderEnabled && settings.isEnabled,
                  onChanged: settings.isEnabled ? (value) {
                    ref.read(notificationProvider.notifier).updateNotificationSettings(
                      settings.copyWith(attendanceReminderEnabled: value),
                    );
                  } : null,
                ),
              ),
              if (settings.isEnabled && settings.attendanceReminderEnabled) ...[
                const Divider(),
                ListTile(
                  title: const Text('알림 요일'),
                  subtitle: Text(_getDayOfWeekText(settings.attendanceReminderDayOfWeek)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showDayOfWeekPicker(settings),
                ),
                ListTile(
                  title: const Text('알림 시간'),
                  subtitle: Text('${settings.attendanceReminderTime.hour.toString().padLeft(2, '0')}:${settings.attendanceReminderTime.minute.toString().padLeft(2, '0')}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showTimePicker(settings),
                ),
              ],
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // 회비 알림 설정
        Card(
          child: ListTile(
            title: const Text('회비 알림'),
            subtitle: const Text('매월 1일에 회비 납부 알림을 받습니다'),
            trailing: NotificationSwitch(
              value: settings.monthlyFeeReminderEnabled && settings.isEnabled,
              onChanged: settings.isEnabled ? (value) {
                ref.read(notificationProvider.notifier).updateNotificationSettings(
                  settings.copyWith(monthlyFeeReminderEnabled: value),
                );
              } : null,
            ),
          ),
        ),
      ],
    );
  }

  /// 요일 선택 다이얼로그 표시
  void _showDayOfWeekPicker(settings) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('알림 요일 선택'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 1; i <= 7; i++)
              ListTile(
                title: Text(_getDayOfWeekText(i)),
                trailing: settings.attendanceReminderDayOfWeek == i
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  ref.read(notificationProvider.notifier).updateNotificationSettings(
                    settings.copyWith(attendanceReminderDayOfWeek: i),
                  );
                  Navigator.of(context).pop();
                },
              ),
          ],
        ),
      ),
    );
  }

  /// 시간 선택 다이얼로그 표시
  void _showTimePicker(settings) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: settings.attendanceReminderTime,
    );
    
    if (picked != null) {
      ref.read(notificationProvider.notifier).updateNotificationSettings(
        settings.copyWith(attendanceReminderTime: picked),
      );
    }
  }

  /// 요일 텍스트 반환
  String _getDayOfWeekText(int dayOfWeek) {
    switch (dayOfWeek) {
      case 1: return '월요일';
      case 2: return '화요일';
      case 3: return '수요일';
      case 4: return '목요일';
      case 5: return '금요일';
      case 6: return '토요일';
      case 7: return '일요일';
      default: return '월요일';
    }
  }
} 