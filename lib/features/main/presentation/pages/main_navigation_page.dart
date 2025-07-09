import 'package:flutter/material.dart';
import '../../../attendance/presentation/pages/attendance_page.dart';
import '../../../post/presentation/pages/post_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../voting/presentation/pages/voting_page.dart';

/// 앱의 메인 네비게이션(홈/투표/출석/프로필) 페이지
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  // 각 탭별 페이지 위젯 리스트 (투표 탭 추가)
  final List<Widget> _pages = const [
    PostPage(),
    VotingPage(),
    AttendancePage(),
    ProfilePage(),
  ];

  // 탭별 제목 (투표 탭 추가)
  final List<String> _titles = [
    'YouMR',
    '투표',
    '출석',
    '프로필',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        height: 64,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color(0x22000000), // 연한 회색 구분선
              width: 1,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000), // 약간 더 진한 그림자
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 홈 탭
            IconButton(
              icon: Icon(
                _currentIndex == 0 ? Icons.home : Icons.home_outlined,
                color: _currentIndex == 0 ? Colors.black : Color(0xFFCCCCCC),
                size: 32,
              ),
              onPressed: () => setState(() => _currentIndex = 0),
              tooltip: '홈',
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              padding: EdgeInsets.zero,
            ),
            // 투표 탭
            IconButton(
              icon: Icon(
                _currentIndex == 1 ? Icons.favorite : Icons.favorite_border,
                color: _currentIndex == 1 ? Colors.red : Color(0xFFCCCCCC),
                size: 32,
              ),
              onPressed: () => setState(() => _currentIndex = 1),
              tooltip: '투표',
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              padding: EdgeInsets.zero,
            ),
            // 출석 탭
            IconButton(
              icon: Icon(
                _currentIndex == 2 ? Icons.check_circle : Icons.check_circle_outline,
                color: _currentIndex == 2 ? Colors.black : Color(0xFFCCCCCC),
                size: 32,
              ),
              onPressed: () => setState(() => _currentIndex = 2),
              tooltip: '출석',
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              padding: EdgeInsets.zero,
            ),
            // 프로필 탭
            IconButton(
              icon: Icon(
                _currentIndex == 3 ? Icons.person : Icons.person_outline,
                color: _currentIndex == 3 ? Colors.black : Color(0xFFCCCCCC),
                size: 32,
              ),
              onPressed: () => setState(() => _currentIndex = 3),
              tooltip: '프로필',
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              padding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }
}