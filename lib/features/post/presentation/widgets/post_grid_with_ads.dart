import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youmr_v2/core/widgets/banner_ad_widget.dart';
import 'post_card.dart';

/// 게시글과 광고를 함께 표시하는 리스트 위젯
/// 지정된 간격마다 광고 배너를 삽입
class PostGridWithAds extends StatelessWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> posts;
  final bool hasMore;
  final ThemeData theme;
  final int adInterval; // 광고 삽입 간격 (기본값: 6개 게시글마다)
  final bool showAdBorder; // 광고 테두리 표시 여부
  
  const PostGridWithAds({
    super.key, 
    required this.posts, 
    required this.hasMore, 
    required this.theme,
    this.adInterval = 6,
    this.showAdBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, idx) {
            // 전체 아이템 수 계산
            final totalItems = _calculateTotalItems();
            
            if (idx >= totalItems) {
              return const SizedBox.shrink();
            }
            
            // 게시글과 광고를 함께 표시할 아이템 리스트 생성
            final items = _buildItems();
            
            return items[idx];
          },
          childCount: _calculateTotalItems(),
        ),
      ),
    );
  }
  
  /// 게시글과 광고를 포함한 아이템 리스트 생성
  List<Widget> _buildItems() {
    final List<Widget> items = [];
    
    for (int i = 0; i < posts.length; i++) {
      // 게시글 추가
      final postData = posts[i].data();
      items.add(
        PostCard(
          postId: posts[i].id,
          title: postData['title'] ?? '',
          content: postData['content'] ?? '',
          author: postData['authorNickname'] ?? '',
          authorProfileUrl: postData['authorProfileUrl'] ?? '',
          createdAt: postData['createdAt'] != null 
              ? (postData['createdAt'] as Timestamp).toDate() 
              : null,
          youtubeUrl: postData['youtubeUrl'],
          likes: postData['likes'] ?? [],
          likesCount: postData['likesCount'] ?? 0,
        ),
      );
      
      // 지정된 간격마다 광고 삽입
      if ((i + 1) % adInterval == 0 && i < posts.length - 1) {
        items.add(_buildAdContainer());
      }
    }
    
    // 무한 스크롤 로딩 인디케이터 추가
    if (hasMore) {
      items.add(
        Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: CircularProgressIndicator(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      );
    }
    
    return items;
  }
  
  /// 광고 컨테이너 생성
  Widget _buildAdContainer() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: showAdBorder ? BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
          width: 1,
        ),
      ) : null,
      child: const BannerAdWidget(),
    );
  }
  
  /// 전체 아이템 수 계산 (게시글 + 광고 + 로딩 인디케이터)
  int _calculateTotalItems() {
    int adCount = (posts.length / adInterval).floor();
    if (posts.length % adInterval == 0 && posts.isNotEmpty) {
      adCount--; // 마지막에 광고가 추가되지 않도록
    }
    
    int totalItems = posts.length + adCount;
    if (hasMore) {
      totalItems++; // 로딩 인디케이터
    }
    
    return totalItems;
  }
} 