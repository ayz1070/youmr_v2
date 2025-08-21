import 'package:flutter/material.dart';
import '../../../../core/constants/app_logger.dart';

/// 게시글 작성 페이지의 헤더 이미지와 제목 입력 위젯
class PostHeaderImage extends StatelessWidget {
  final String? youtubeThumb;
  final String backgroundImage; // picsumUrl을 backgroundImage로 변경
  final TextEditingController titleController;
  final String? Function(String?)? validator;

  const PostHeaderImage({
    super.key,
    required this.youtubeThumb,
    required this.backgroundImage, // picsumUrl을 backgroundImage로 변경
    required this.titleController,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    
    return Stack(
      children: [
                // 배경 이미지
        ClipRRect(
          borderRadius: BorderRadius.zero,
          child: (youtubeThumb != null)
              ? Image.network(
                  youtubeThumb!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 340,
                  loadingBuilder: (context, child, progress) => progress == null
                      ? child
                      : _buildLoadingContainer(),
                  errorBuilder: (context, error, stackTrace) {
                    AppLogger.w('YouTube 썸네일 로드 실패: $error');
                    return _buildDefaultImageContainer();
                  },
                )
              : Image.network(
                  backgroundImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 340,
                  loadingBuilder: (context, child, progress) => progress == null
                      ? child
                      : _buildLoadingContainer(),
                  errorBuilder: (context, error, stackTrace) {
                    AppLogger.w('배경 이미지 로드 실패: $error');
                    return _buildDefaultImageContainer();
                  },
                ),
        ),
        // 제목 입력 필드
        Positioned(
          left: 0,
          right: 0,
          bottom: 32,
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextFormField(
                controller: titleController,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 22,
                  shadows: const [
                    Shadow(
                      color: Colors.black38,
                      blurRadius: 4,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '제목을 입력하세요',
                  hintStyle: TextStyle(color: Colors.white70),
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
                validator: validator,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 로딩 상태를 표시하는 컨테이너
  Widget _buildLoadingContainer() {
    return Container(
      color: Colors.grey[300],
      width: double.infinity,
      height: 340,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  /// 기본 이미지를 표시하는 컨테이너
  Widget _buildDefaultImageContainer() {
    return Container(
      width: double.infinity,
      height: 340,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        image: const DecorationImage(
          image: AssetImage('assets/images/default_post_image.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
} 