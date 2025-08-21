import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

/// 게시글 도메인 엔티티
/// - 비즈니스 로직에서 사용하는 게시글의 핵심 속성을 정의
/// - 도메인 규칙과 유효성 검사를 포함
@freezed
class Post with _$Post {
  /// 게시글 도메인 엔티티 생성자
  /// [id] 게시글 고유 ID
  /// [authorId] 작성자 ID
  /// [authorNickname] 작성자 닉네임
  /// [authorProfileUrl] 작성자 프로필 이미지 URL
  /// [title] 제목
  /// [content] 내용
  /// [category] 카테고리
  /// [createdAt] 생성일
  /// [updatedAt] 수정일
  /// [likeCount] 좋아요 수
  /// [commentCount] 댓글 수
  /// [imageUrls] 이미지 URL 리스트
  /// [backgroundImage] 배경 이미지 URL
  /// [isNotice] 공지사항 여부
  /// [likes] 좋아요한 사용자 ID 리스트
  /// [youtubeUrl] 유튜브 URL
  const factory Post({
    required String id,
    required String authorId,
    required String authorNickname,
    @Default('') String authorProfileUrl,
    required String title,
    required String content,
    required String category,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(0) int likeCount,
    @Default(0) int commentCount,
    @Default([]) List<String> imageUrls,
    @Default('') String backgroundImage,
    @Default(false) bool isNotice,
    @Default([]) List<String> likes,
    @Default('') String youtubeUrl,
  }) = _Post;

  /// JSON → Post 변환
  /// [json]: JSON 맵
  /// 반환: [Post] 인스턴스
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  /// 게시글 생성 팩토리 메서드
  /// [authorId]: 작성자 ID
  /// [authorNickname]: 작성자 닉네임
  /// [authorProfileUrl]: 작성자 프로필 이미지 URL
  /// [title]: 제목
  /// [content]: 내용
  /// [category]: 카테고리
  /// [imageUrls]: 이미지 URL 리스트
  /// [backgroundImage]: 배경 이미지 URL
  /// [youtubeUrl]: 유튜브 URL
  /// 반환: 새로운 Post 인스턴스
  factory Post.create({
    required String authorId,
    required String authorNickname,
    String? authorProfileUrl,
    required String title,
    required String content,
    required String category,
    List<String>? imageUrls,
    String? backgroundImage,
    String? youtubeUrl,
  }) {
    // 제목 유효성 검증
    if (title.trim().isEmpty || title.length > 100) {
      throw ArgumentError('제목은 1자 이상 100자 이하여야 합니다: $title');
    }

    
    return Post(
      id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
      authorId: authorId,
      authorNickname: authorNickname,
      authorProfileUrl: authorProfileUrl ?? '',
      title: title.trim(),
      content: content,
      category: category,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      imageUrls: imageUrls ?? [],
      backgroundImage: backgroundImage ?? '',
      youtubeUrl: youtubeUrl ?? '',
    );
  }
}

/// Post 엔티티 확장 메서드
extension PostExtension on Post {


  /// 게시글이 오늘 작성되었는지 확인
  bool get isCreatedToday {
    final now = DateTime.now();
    return createdAt.year == now.year && 
           createdAt.month == now.month && 
           createdAt.day == now.day;
  }

  /// 게시글이 어제 작성되었는지 확인
  bool get isCreatedYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return createdAt.year == yesterday.year && 
           createdAt.month == yesterday.month && 
           createdAt.day == yesterday.day;
  }

  /// 게시글이 이번 주에 작성되었는지 확인
  bool get isCreatedThisWeek {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    
    return createdAt.isAfter(startOfWeek.subtract(const Duration(days: 1))) && 
           createdAt.isBefore(endOfWeek.add(const Duration(days: 1)));
  }

  /// 게시글이 인기 있는지 확인 (좋아요 10개 이상)
  bool get isPopular => likeCount >= 10;

  /// 게시글이 활발한지 확인 (댓글 5개 이상)
  bool get isActive => commentCount >= 5;

  /// 게시글에 이미지가 있는지 확인
  bool get hasImages => imageUrls.isNotEmpty;

  /// 게시글에 배경 이미지가 있는지 확인
  bool get hasBackgroundImage => backgroundImage.isNotEmpty;

  /// 게시글에 유튜브 링크가 있는지 확인
  bool get hasYoutubeLink => youtubeUrl.isNotEmpty;

  /// 게시글을 좋아요할 수 있는지 확인
  /// [userId]: 사용자 ID
  /// 반환: 좋아요 가능 여부
  bool canLike(String userId) {
    return !likes.contains(userId) && authorId != userId;
  }

  /// 게시글을 좋아요 취소할 수 있는지 확인
  /// [userId]: 사용자 ID
  /// 반환: 좋아요 취소 가능 여부
  bool canUnlike(String userId) {
    return likes.contains(userId);
  }

  /// 게시글을 수정할 수 있는지 확인
  /// [userId]: 사용자 ID
  /// 반환: 수정 가능 여부
  bool canEdit(String userId) {
    return authorId == userId && !isNotice;
  }

  /// 게시글을 삭제할 수 있는지 확인
  /// [userId]: 사용자 ID
  /// 반환: 삭제 가능 여부
  bool canDelete(String userId) {
    return authorId == userId && !isNotice;
  }

  /// 게시글을 공지로 설정할 수 있는지 확인
  /// [userId]: 사용자 ID
  /// 반환: 공지 설정 가능 여부
  bool canSetNotice(String userId) {
    // 관리자 권한 체크는 별도 로직에서 처리
    return authorId == userId;
  }

  /// 게시글 요약 정보 반환
  /// [maxLength]: 최대 길이
  /// 반환: 요약된 내용
  String getSummary(int maxLength) {
    if (content.length <= maxLength) return content;
    return '${content.substring(0, maxLength)}...';
  }

  /// 게시글 통계 정보 반환
  /// 반환: 통계 정보 맵
  Map<String, dynamic> getStatistics() {
    return {
      'likeCount': likeCount,
      'commentCount': commentCount,
      'imageCount': imageUrls.length,
      'hasBackgroundImage': hasBackgroundImage,
      'hasYoutubeLink': hasYoutubeLink,
      'isPopular': isPopular,
      'isActive': isActive,
    };
  }
} 