import 'package:youmr_v2/core/constants/app_logger.dart';

/// YouTube 관련 유틸리티 함수들
class YouTubeUtils {
  /// YouTube 썸네일 URL 추출 (개선된 버전)
  /// [url]: YouTube URL
  /// [quality]: 썸네일 품질 (기본값: 'hqdefault')
  /// 반환: 썸네일 이미지 URL 또는 null
  static String? getThumbnail(String? url, {String quality = 'hqdefault'}) {
    if (url == null || url.isEmpty) {
      AppLogger.i('YouTube URL이 null이거나 비어있음');
      return null;
    }
    
    AppLogger.i('YouTube URL 파싱 시작: $url');
    
    try {
      final uri = Uri.parse(url);
      AppLogger.i('파싱된 URI: $uri');
      AppLogger.i('호스트: ${uri.host}');
      AppLogger.i('경로: ${uri.pathSegments}');
      AppLogger.i('쿼리 파라미터: ${uri.queryParameters}');
      
      // YouTube 도메인 확인
      if (!uri.host.contains('youtu')) {
        AppLogger.i('YouTube 도메인이 아님: ${uri.host}');
        return null;
      }
      
      String? videoId;
      
      // 다양한 YouTube URL 형식 지원
      if (uri.host.contains('youtube.com')) {
        // https://www.youtube.com/watch?v=VIDEO_ID
        videoId = uri.queryParameters['v'];
        AppLogger.i('쿼리 파라미터 v에서 추출된 videoId: $videoId');
        
        // https://www.youtube.com/embed/VIDEO_ID
        if (videoId == null && uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'embed') {
          videoId = uri.pathSegments.length >= 2 ? uri.pathSegments[1] : null;
          AppLogger.i('embed 경로에서 추출된 videoId: $videoId');
        }
        
        // https://www.youtube.com/v/VIDEO_ID
        if (videoId == null && uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'v') {
          videoId = uri.pathSegments.length >= 2 ? uri.pathSegments[1] : null;
          AppLogger.i('v 경로에서 추출된 videoId: $videoId');
        }
      } else if (uri.host.contains('youtu.be')) {
        // https://youtu.be/VIDEO_ID
        videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
        AppLogger.i('youtu.be 경로에서 추출된 videoId: $videoId');
      } else if (uri.host.contains('youtube-nocookie.com')) {
        // https://www.youtube-nocookie.com/embed/VIDEO_ID
        videoId = uri.pathSegments.length >= 2 ? uri.pathSegments[1] : null;
        AppLogger.i('youtube-nocookie.com 경로에서 추출된 videoId: $videoId');
      }
      
      if (videoId == null || videoId.length < 5) {
        AppLogger.i('유효하지 않은 videoId: $videoId');
        return null;
      }
      
      // 썸네일 URL 생성
      final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/$quality.jpg';
      AppLogger.i('생성된 썸네일 URL: $thumbnailUrl');
      return thumbnailUrl;
    } catch (e) {
      // URL 파싱 실패 시 null 반환
      AppLogger.e('YouTube URL 파싱 실패: $e');
      return null;
    }
  }

  /// YouTube 썸네일 URL 추출 (간단한 버전, 로깅 없음)
  /// [url]: YouTube URL
  /// [quality]: 썸네일 품질 (기본값: 'hqdefault')
  /// 반환: 썸네일 이미지 URL 또는 null
  static String? getThumbnailSimple(String? url, {String quality = 'hqdefault'}) {
    if (url == null || url.isEmpty) return null;
    
    try {
      final uri = Uri.parse(url);
      
      // YouTube 도메인 확인
      if (!uri.host.contains('youtu')) return null;
      
      String? videoId;
      
      // 다양한 YouTube URL 형식 지원
      if (uri.host.contains('youtube.com')) {
        // https://www.youtube.com/watch?v=VIDEO_ID
        videoId = uri.queryParameters['v'];
        
        // https://www.youtube.com/embed/VIDEO_ID
        if (videoId == null && uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'embed') {
          videoId = uri.pathSegments.length >= 2 ? uri.pathSegments[1] : null;
        }
        
        // https://www.youtube.com/v/VIDEO_ID
        if (videoId == null && uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'v') {
          videoId = uri.pathSegments.length >= 2 ? uri.pathSegments[1] : null;
        }
      } else if (uri.host.contains('youtu.be')) {
        // https://youtu.be/VIDEO_ID
        videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
      } else if (uri.host.contains('youtube-nocookie.com')) {
        // https://www.youtube-nocookie.com/embed/VIDEO_ID
        videoId = uri.pathSegments.length >= 2 ? uri.pathSegments[1] : null;
      }
      
      if (videoId == null || videoId.length < 5) return null;
      
      // 썸네일 URL 생성
      return 'https://img.youtube.com/vi/$videoId/$quality.jpg';
    } catch (e) {
      return null;
    }
  }

  /// YouTube URL이 유효한지 확인
  /// [url]: 확인할 URL
  /// 반환: 유효한 YouTube URL 여부
  static bool isValidYouTubeUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    
    try {
      final uri = Uri.parse(url);
      return uri.host.contains('youtu');
    } catch (e) {
      return false;
    }
  }

  /// YouTube URL에서 videoId 추출
  /// [url]: YouTube URL
  /// 반환: videoId 또는 null
  static String? extractVideoId(String? url) {
    if (url == null || url.isEmpty) return null;
    
    try {
      final uri = Uri.parse(url);
      
      if (!uri.host.contains('youtu')) return null;
      
      String? videoId;
      
      if (uri.host.contains('youtube.com')) {
        videoId = uri.queryParameters['v'];
        
        if (videoId == null && uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'embed') {
          videoId = uri.pathSegments.length >= 2 ? uri.pathSegments[1] : null;
        }
        
        if (videoId == null && uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'v') {
          videoId = uri.pathSegments.length >= 2 ? uri.pathSegments[1] : null;
        }
      } else if (uri.host.contains('youtu.be')) {
        videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
      } else if (uri.host.contains('youtube-nocookie.com')) {
        videoId = uri.pathSegments.length >= 2 ? uri.pathSegments[1] : null;
      }
      
      return (videoId != null && videoId.length >= 5) ? videoId : null;
    } catch (e) {
      return null;
    }
  }
}
