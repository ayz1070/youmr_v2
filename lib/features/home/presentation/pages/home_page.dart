import 'package:flutter/material.dart';
// import 'post_detail_page.dart'; // post feature로 분리됨
// import 'post_edit_page.dart'; // post feature로 분리됨
// import '../widgets/post_card.dart'; // post feature로 분리됨
import '../../../post/presentation/pages/post_list_page.dart';

/// 홈 페이지 (post feature 의존성 분리)
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PostListPage(), // post feature의 게시글 목록 사용
    );
  }
} 