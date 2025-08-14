import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youmr_v2/core/constants/app_logger.dart';

/// 게시글 생성용 DTO
/// 게시글 생성 시 필요한 데이터만 포함하며, repository에서 분리된 구조
class CreatePostDto {
  /// 작성자 ID
  final String authorId;
  /// 작성자 닉네임
  final String authorNickname;
  /// 작성자 프로필 이미지 URL
  final String authorProfileUrl;
  /// 제목
  final String title;
  /// 내용
  final String content;
  /// 카테고리
  final String category;
  /// 생성일
  final DateTime createdAt;
  /// 수정일
  final DateTime updatedAt;
  /// 이미지 URL 리스트
  final List<String> imageUrls;
  /// 배경 이미지 URL
  final String backgroundImage;
  /// 공지사항 여부
  final bool isNotice;
  /// 유튜브 URL
  final String youtubeUrl;

  /// CreatePostDto 생성자
  const CreatePostDto({
    required this.authorId,
    required this.authorNickname,
    required this.authorProfileUrl,
    required this.title,
    required this.content,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    this.imageUrls = const [],
    this.backgroundImage = '',
    this.isNotice = false,
    this.youtubeUrl = '',
  });

  /// Map으로 변환 (Firestore 저장용)
  /// 반환: Firestore에 저장할 Map 데이터
  Map<String, dynamic> toMap() {
    try {
      return {
        'authorId': authorId,
        'authorNickname': authorNickname,
        'authorProfileUrl': authorProfileUrl,
        'title': title,
        'content': content,
        'category': category,
        'createdAt': Timestamp.fromDate(createdAt),
        'updatedAt': Timestamp.fromDate(updatedAt),
        'imageUrls': imageUrls,
        'backgroundImage': backgroundImage,
        'isNotice': isNotice,
        'youtubeUrl': youtubeUrl,
        // 기본값 설정
        'likeCount': 0,
        'commentCount': 0,
        'likes': <String>[],
      };
    } catch (e, stackTrace) {
      AppLogger.e("CreatePostDto.toMap 변환 실패: $e");
      AppLogger.e("스택 트레이스: $stackTrace");
      rethrow;
    }
  }

  /// JSON → CreatePostDto 변환
  /// [json]: JSON 맵 데이터
  /// 반환: CreatePostDto 인스턴스
  factory CreatePostDto.fromJson(Map<String, dynamic> json) {
    try {
      return CreatePostDto(
        authorId: json['authorId']?.toString() ?? '',
        authorNickname: json['authorNickname']?.toString() ?? '',
        authorProfileUrl: json['authorProfileUrl']?.toString() ?? '',
        title: json['title']?.toString() ?? '',
        content: json['content']?.toString() ?? '',
        category: json['category']?.toString() ?? '일반',
        createdAt: _parseDateTime(json['createdAt']),
        updatedAt: _parseDateTime(json['updatedAt']),
        imageUrls: _parseStringList(json['imageUrls']),
        backgroundImage: json['backgroundImage']?.toString() ?? '',
        isNotice: json['isNotice'] == true,
        youtubeUrl: json['youtubeUrl']?.toString() ?? '',
      );
    } catch (e, stackTrace) {
      AppLogger.e("CreatePostDto.fromJson 변환 실패: $e");
      AppLogger.e("스택 트레이스: $stackTrace");
      rethrow;
    }
  }

  /// DateTime 파싱 헬퍼 메서드
  static DateTime _parseDateTime(dynamic value) {
    try {
      if (value is Timestamp) return value.toDate();
      if (value is String) return DateTime.parse(value);
      return DateTime.now();
    } catch (e) {
      return DateTime.now();
    }
  }

  /// String 리스트 파싱 헬퍼 메서드
  static List<String> _parseStringList(dynamic value) {
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }
    return [];
  }

  /// CreatePostDto 복사본 생성
  /// [authorId]: 새로운 작성자 ID
  /// [authorNickname]: 새로운 작성자 닉네임
  /// [authorProfileUrl]: 새로운 작성자 프로필 이미지 URL
  /// [title]: 새로운 제목
  /// [content]: 새로운 내용
  /// [category]: 새로운 카테고리
  /// [imageUrls]: 새로운 이미지 URL 리스트
  /// [backgroundImage]: 새로운 배경 이미지 URL
  /// [isNotice]: 새로운 공지사항 여부
  /// [youtubeUrl]: 새로운 유튜브 URL
  /// 반환: 새로운 CreatePostDto 인스턴스
  CreatePostDto copyWith({
    String? authorId,
    String? authorNickname,
    String? authorProfileUrl,
    String? title,
    String? content,
    String? category,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? imageUrls,
    String? backgroundImage,
    bool? isNotice,
    String? youtubeUrl,
  }) {
    return CreatePostDto(
      authorId: authorId ?? this.authorId,
      authorNickname: authorNickname ?? this.authorNickname,
      authorProfileUrl: authorProfileUrl ?? this.authorProfileUrl,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      imageUrls: imageUrls ?? this.imageUrls,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      isNotice: isNotice ?? this.isNotice,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
    );
  }

  @override
  String toString() {
    return 'CreatePostDto(authorId: $authorId, authorNickname: $authorNickname, authorProfileUrl: $authorProfileUrl, title: $title, category: $category, isNotice: $isNotice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CreatePostDto &&
        other.authorId == authorId &&
        other.authorNickname == authorNickname &&
        other.authorProfileUrl == authorProfileUrl &&
        other.title == title &&
        other.content == content &&
        other.category == category &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.imageUrls == imageUrls &&
        other.backgroundImage == backgroundImage &&
        other.isNotice == isNotice &&
        other.youtubeUrl == youtubeUrl;
  }

  @override
  int get hashCode {
    return Object.hash(
      authorId,
      authorNickname,
      authorProfileUrl,
      title,
      content,
      category,
      createdAt,
      updatedAt,
      imageUrls,
      backgroundImage,
      isNotice,
      youtubeUrl,
    );
  }
}
