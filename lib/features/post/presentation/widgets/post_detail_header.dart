import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youmr_v2/features/auth/presentation/providers/auth_provider.dart';

import '../../di/post_detail_module.dart';
import 'comment_count.dart';

/// 게시글 상세 헤더 위젯
/// - 이미지, 제목, 작성자 정보, 좋아요 기능을 포함
/// - 클린 아키텍처 원칙에 따라 use case를 통해 데이터 처리
class PostDetailHeader extends ConsumerStatefulWidget {
  final String postId;
  final String? thumb;
  final String backgroundImage; // picsumUrl을 backgroundImage로 변경
  final String author;
  final String authorProfileUrl;
  final DateTime? createdAt;
  final String title;
  final int likeCount;
  final String? youtubeUrl;
  
  /// 생성자
  const PostDetailHeader({
    super.key, 
    required this.postId, 
    required this.thumb, 
    required this.backgroundImage, // picsumUrl을 backgroundImage로 변경
    required this.author, 
    required this.authorProfileUrl, 
    required this.createdAt, 
    required this.title, 
    required this.likeCount, 
    this.youtubeUrl
  });

  @override
  ConsumerState<PostDetailHeader> createState() => _PostDetailHeaderState();
}

class _PostDetailHeaderState extends ConsumerState<PostDetailHeader> {
  bool _liked = false; // 기본값으로 초기화
  late int _likeCount;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.likeCount;
    _fetchLikes();
  }

  /// 좋아요 정보 조회
  Future<void> _fetchLikes() async {
    try {
      // Provider를 통해 현재 사용자 ID 가져오기
      final authState = ref.read(authProvider);
      if (authState.value == null) return;

      // Provider를 통해 UseCase 사용
      final checkLikeStatus = ref.read(checkLikeStatusProvider);
      final result = await checkLikeStatus(
        postId: widget.postId, 
        userId: authState.value!.uid
      );
      
      result.fold(
        (failure) {
          // 에러 처리 (로깅 등)
          debugPrint('좋아요 정보 조회 실패: ${failure.message}');
        },
        (isLiked) {
          setState(() {
            _liked = isLiked;
          });
        },
      );
    } catch (e) {
      // 에러 처리 (로깅 등)
      debugPrint('좋아요 정보 조회 실패: $e');
    }
  }

  /// 좋아요 토글 처리
  Future<void> _toggleLike() async {
    // Provider를 통해 현재 사용자 ID 가져오기
    final authState = ref.read(authProvider);
    if (authState.value == null) return;

    // 현재 상태 저장 (복원용)
    final originalLiked = _liked;
    final originalLikeCount = _likeCount;

    // 낙관적 업데이트
    setState(() {
      _liked = !_liked;  // 현재 상태를 반대로 토글
      if (_liked) {
        _likeCount++;
      } else {
        _likeCount--;
      }
      _isLoading = true;
    });

    try {
      // Provider를 통해 UseCase 사용
      final toggleLike = ref.read(toggleLikeProvider);
      final result = await toggleLike(
        postId: widget.postId, 
        userId: authState.value!.uid, 
        isLiked: originalLiked  // 원래 상태 전달 (낙관적 업데이트 전 상태)
      );
      
      result.fold(
        (failure) {
          // 실패 시 원래 상태로 복원
          setState(() {
            _liked = originalLiked;
            _likeCount = originalLikeCount;
          });
          
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('좋아요 처리에 실패했습니다: ${failure.message}')),
            );
          }
        },
        (newLikeStatus) {
          // 성공 시 서버 응답으로 상태 업데이트
          setState(() {
            _liked = newLikeStatus;
            // 서버 응답에 맞게 카운트 조정
            if (newLikeStatus != originalLiked) { // 상태가 실제로 변경된 경우에만
              if (newLikeStatus) {
                _likeCount = originalLikeCount + 1;
              } else {
                _likeCount = originalLikeCount - 1;
              }
            }
          });
        },
      );
    } catch (e) {
      // 에러 시 원래 상태로 복원
      setState(() {
        _liked = originalLiked;
        _likeCount = originalLikeCount;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('좋아요 처리에 실패했습니다.')),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: 'postImage_${widget.postId}',
          child: SizedBox(
            width: double.infinity,
            height: 320,
            child: (widget.thumb != null)
                ? Image.network(
                    widget.thumb!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // 썸네일 로딩 실패 시 배경 이미지로 fallback
                      return Image.network(
                        widget.backgroundImage,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // 배경 이미지도 실패 시 기본 이미지
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.image_not_supported,
                              size: 64,
                              color: Colors.grey,
                            ),
                          );
                        },
                      );
                    },
                  )
                : Image.network(
                    widget.backgroundImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // 배경 이미지 로딩 실패 시 기본 이미지
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 64,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 320,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.55),
              ],
            ),
          ),
        ),
        if (widget.thumb != null)
          Positioned.fill(
            child: Center(
              child: GestureDetector(
                onTap: () {
                  if (widget.youtubeUrl != null && widget.youtubeUrl!.isNotEmpty) {
                    _launchYoutubeUrl(widget.youtubeUrl!);
                  }
                },
                child: Container(
                  width: 70,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE53E3E), // YouTube 빨간색
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: (widget.authorProfileUrl.isNotEmpty)
                          ? NetworkImage(widget.authorProfileUrl)
                          : const AssetImage('assets/images/default_profile.png') as ImageProvider,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.author,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [Shadow(color: Colors.black45, blurRadius: 2)],
                      ),
                    ),
                    const Spacer(),
                    if (widget.createdAt != null)
                      Text(
                        _formatDate(widget.createdAt!),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          shadows: [Shadow(color: Colors.black38, blurRadius: 2)],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: _isLoading ? null : _toggleLike,
                      child: Icon(
                        _liked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                        size: 18,
                        color: _isLoading ? Colors.white54 : Colors.white,
                        shadows: [Shadow(color: Colors.black38, blurRadius: 2)],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$_likeCount', 
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: _isLoading ? Colors.white54 : Colors.white, 
                        shadows: [Shadow(color: Colors.black38, blurRadius: 2)]
                      )
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.mode_comment_outlined, size: 18, color: Colors.white, shadows: [Shadow(color: Colors.black38, blurRadius: 2)]),
                    const SizedBox(width: 4),
                    CommentCount(postId: widget.postId),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// YouTube 링크로 이동하는 함수
  Future<void> _launchYoutubeUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('YouTube 링크를 열 수 없습니다.');
    }
  }

  /// 날짜 포맷팅
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (now.year == date.year && now.month == date.month && now.day == date.day) {
      // 오늘
      return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else {
      return "${date.year % 100}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}";
    }
  }
}