import 'package:flutter/material.dart';
import '../../domain/entities/vote.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youmr_v2/core/constants/app_constants.dart';

/// 투표 리스트의 개별 곡 아이템 커스텀 위젯
class VotingItem extends StatelessWidget {
  final Vote vote;
  final int rank; // 1부터 시작하는 순위
  final bool selected;
  final void Function(String voteId) onToggle;

  const VotingItem({
    super.key,
    required this.vote,
    required this.rank,
    required this.selected,
    required this.onToggle,
  });

  /// 유튜브 썸네일 URL 생성
  String? getYoutubeThumbnail(String? url) {
    if (url == null || url.isEmpty) return null;
    final uri = Uri.tryParse(url);
    if (uri == null) return null;
    String? videoId;
    if (uri.host.contains('youtu.be')) {
      videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : null;
    } else if (uri.host.contains('youtube.com')) {
      videoId = uri.queryParameters['v'];
    }
    if (videoId == null || videoId.isEmpty) return null;
    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }

  /// 유튜브 링크로 이동
  Future<void> _launchYoutube(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('유튜브를 열 수 없습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? thumbnailUrl = getYoutubeThumbnail(vote.youtubeUrl);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 순위
          SizedBox(
            width: 28,
            child: Text(
              '$rank',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 8),
          // 썸네일 or 기본 이미지 (중앙 Crop으로 letterbox 제거)
          InkWell(
            onTap: (vote.youtubeUrl != null && vote.youtubeUrl!.isNotEmpty)
                ? () => _launchYoutube(context, vote.youtubeUrl!)
                : null,
            child: ClipRRect(
              child: thumbnailUrl != null
                  ? ClipRect(
                      child: Align(
                        alignment: Alignment.center,
                        heightFactor: 0.7, // 중앙 70%만 보여줌 (letterbox 제거)
                        child: Image.network(
                          thumbnailUrl,
                          width: 48,
                          height: 68,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
              // TODO 투표 기본 이미지 수정
                  : Image.asset(
                      AppConstants.defaultProfileImage,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(width: 12),
          // 곡 정보
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vote.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  vote.artist,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // 투표수
          SizedBox(
            width: 48,
            child: Text(
              '${vote.voteCount} PICK',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // 체크박스
          Checkbox(
            value: selected,
            onChanged: (_) => onToggle(vote.id),
          ),
        ],
      ),
    );
  }
} 