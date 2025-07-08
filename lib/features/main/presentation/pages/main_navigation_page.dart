import 'package:flutter/material.dart';
import '../../../attendance/presentation/pages/attendance_page.dart';
import '../../../post/presentation/pages/post_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';

/// 앱의 메인 네비게이션(홈/출석/글쓰기/프로필) 페이지
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  // 각 탭별 페이지 위젯 리스트
  final List<Widget> _pages = const [
    PostPage(),
    AttendancePage(),
    ProfilePage(),
  ];

  // 탭별 제목
  final List<String> _titles = [
    'YouMR',
    '출석',
    '프로필',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: '홈',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle_outline),
            selectedIcon: Icon(Icons.check_circle),
            label: '출석',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}