import 'package:flutter/material.dart';
import 'member_management_page.dart';
import 'notice_management_page.dart';
import 'statistics_page.dart';

/// 관리자 메인 페이지 (회원관리/공지글관리/통계)
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
    StatisticsPage(),
  ];
  final _titles = const ['회원 관리', '공지글 관리', '통계'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_tabIndex])),
      body: _pages[_tabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        onTap: (i) => setState(() => _tabIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.people), label: '회원'),
          BottomNavigationBarItem(icon: Icon(Icons.campaign), label: '공지글'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: '통계'),
        ],
      ),
    );
  }
} 