import 'package:flutter/material.dart';
import 'package:youmr_v2/features/post/domain/entities/post.dart';
import 'package:youmr_v2/features/post/presentation/widgets/post_detail_content.dart';
import 'package:youmr_v2/features/post/presentation/widgets/post_detail_header.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youmr_v2/core/utils/youtube_utils.dart';

/// 게시글 상세 본문 위젯
/// - 클린 아키텍처 원칙에 따라 domain layer에서 전달받은 Post 엔티티를 표시
class PostDetailBody extends StatelessWidget {
  final Post? post;
  final YoutubePlayerController? ytController;
  final bool isLoading;
  final String? error;
  
  /// 생성자
  const PostDetailBody({
    super.key, 
    required this.post, 
    required this.ytController, 
    required this.isLoading, 
    this.error
  });

  @override
  Widget build(BuildContext context) {
    if (post == null) {
      return const Center(child: Text('게시글 정보가 없습니다.'));
    }
    
    final postId = post!.id;
    final title = post!.title;
    final content = post!.content;
    final author = post!.authorNickname;
    final createdAt = post!.createdAt;
    final youtubeUrl = post!.youtubeUrl;
    final likeCount = post!.likeCount;
    final thumb = YouTubeUtils.getThumbnail(youtubeUrl);
    
    // Post 엔티티의 backgroundImage 사용 (없으면 picsum fallback)
    final backgroundImage = post!.backgroundImage.isNotEmpty 
        ? post!.backgroundImage 
        : 'https://picsum.photos/seed/$postId/800/420';
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostDetailHeader(
            postId: postId,
            thumb: thumb,
            backgroundImage: backgroundImage,
            author: author,
            authorProfileUrl: post!.authorProfileUrl, // Post 엔티티의 authorProfileUrl 사용
            createdAt: createdAt,
            title: title,
            likeCount: likeCount,
            youtubeUrl: youtubeUrl,
          ),
          PostDetailContent(content: content, likeCount: likeCount),
        ],
      ),
    );
  }


}


