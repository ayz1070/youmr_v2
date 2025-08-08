import 'package:flutter/material.dart';
import 'member_management_page.dart';
import 'notice_management_page.dart';
import 'notice_write_page.dart';
import 'fee_notification_page.dart';
import 'attendance_notification_page.dart';
import 'package:youmr_v2/features/notification/presentation/pages/admin_notification_page.dart';

/// 관리자 메인 페이지 (회원관리/공지글관리/알림전송/회비알림/출석알림)
class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _tabIndex = 0;
  final _pages = const [
    MemberManagementPage(),
    NoticeManagementPage(),
    AdminNotificationPage(),
    FeeNotificationPage(),
    AttendanceNotificationPage(),
  ];
  final _titles = const ['회원 관리', '공지글 관리', '알림 전송', '회비 알림', '출석 알림'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_tabIndex]),
        actions: [
          // 공지글 관리 탭에서만 공지글 작성 버튼 표시
          if (_tabIndex == 1)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const NoticeWritePage()),
                );
                // 공지글 작성 성공 시 스낵바 표시
                if (result == true && mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('공지글이 작성되었습니다. 목록이 자동으로 새로고침됩니다.'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              tooltip: '공지글 작성',
            ),
        ],
      ),
      body: _pages[_tabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        onTap: (i) => setState(() => _tabIndex = i),
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.people), label: '회원'),
          BottomNavigationBarItem(icon: Icon(Icons.campaign), label: '공지'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: '알림'),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: '회비'),
          BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: '출석'),
        ],
      ),
    );
  }
} 