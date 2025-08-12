import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/post.dart';
import 'package:youmr_v2/core/constants/app_logger.dart';

/// 게시글 DTO
/// 외부 데이터(JSON) ↔ 내부 엔티티(Post) 변환을 담당합니다.
class PostDto {
  /// 게시글 고유 ID
  final String id;
  /// 작성자 ID
  final String authorId;
  /// 작성자 이름
  final String authorName;
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
  /// 좋아요 수
  final int likeCount;
  /// 댓글 수
  final int commentCount;
  /// 이미지 URL 리스트
  final List<String> imageUrls;
  /// 배경 이미지 URL
  final String backgroundImage;
  /// 공지사항 여부
  final bool isNotice;
  /// 좋아요한 사용자 ID 리스트
  final List<String> likes;
  /// 유튜브 URL
  final String youtubeUrl;

  /// 게시글 DTO 생성자
  const PostDto({
    required this.id,
    required this.authorId,
    required this.authorName,
    required this.title,
    required this.content,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    this.likeCount = 0,
    this.commentCount = 0,
    this.imageUrls = const [],
    this.backgroundImage = '',
    this.isNotice = false,
    this.likes = const [],
    this.youtubeUrl = '',
  });

  /// JSON → PostDto 변환 (타입 안전성 검증 포함)
  /// [json]: Firestore 문서 데이터
  /// [documentId]: 문서 ID (필드에 id가 없는 경우 사용)
  factory PostDto.fromJson(Map<String, dynamic> json, {String? documentId}) {
    try {
      // 문서 ID 처리
      final id = documentId ?? json['id']?.toString() ?? '';
      
      // 필드 매핑 및 변환
      final authorId = json['authorUid']?.toString() ?? json['authorId']?.toString() ?? '';
      final authorName = json['authorNickname']?.toString() ?? json['authorName']?.toString() ?? '';
      final title = json['title']?.toString() ?? '';
      final content = json['content']?.toString() ?? '';
      final category = json['category']?.toString() ?? '일반';
      
      // DateTime 변환
      final createdAt = _parseDateTime(json['createdAt']);
      final updatedAt = _parseDateTime(json['updatedAt']);
      
      // 숫자 필드 변환
      final likeCount = _parseInt(json['likesCount'] ?? json['likeCount']);
      final commentCount = _parseInt(json['commentsCount'] ?? json['commentCount']);
      
      // 리스트 필드 변환
      final imageUrls = _parseStringList(json['imageUrls']);
      final likes = _parseStringList(json['likes']);
      
      // 기타 필드
      final backgroundImage = json['backgroundImage']?.toString() ?? '';
      final isNotice = json['isNotice'] == true;
      final youtubeUrl = json['youtubeUrl']?.toString() ?? '';
      
      return PostDto(
        id: id,
        authorId: authorId,
        authorName: authorName,
        title: title,
        content: content,
        category: category,
        createdAt: createdAt,
        updatedAt: updatedAt,
        likeCount: likeCount,
        commentCount: commentCount,
        imageUrls: imageUrls,
        backgroundImage: backgroundImage,
        isNotice: isNotice,
        likes: likes,
        youtubeUrl: youtubeUrl,
      );
      
    } catch (e, stackTrace) {
      AppLogger.e("PostDto.fromJson 변환 실패: $e");
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

  /// int 파싱 헬퍼 메서드
  static int _parseInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '0') ?? 0;
  }

  /// String 리스트 파싱 헬퍼 메서드
  static List<String> _parseStringList(dynamic value) {
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }
    return [];
  }
}

/// PostDto <-> Post 변환 확장
extension PostDtoDomainMapper on PostDto {
  /// DTO → 도메인 엔티티
  Post toDomain() => Post(
        id: id,
        authorId: authorId,
        authorName: authorName,
        title: title,
        content: content,
        category: category,
        createdAt: createdAt,
        updatedAt: updatedAt,
        likeCount: likeCount,
        commentCount: commentCount,
        imageUrls: imageUrls,
        backgroundImage: backgroundImage,
        isNotice: isNotice,
        likes: likes,
        youtubeUrl: youtubeUrl,
      );
}

extension PostDtoFromDomain on Post {
  /// 도메인 엔티티 → DTO
  PostDto toDto() => PostDto(
        id: id,
        authorId: authorId,
        authorName: authorName,
        title: title,
        content: content,
        category: category,
        createdAt: createdAt,
        updatedAt: updatedAt,
        likeCount: likeCount,
        commentCount: commentCount,
        imageUrls: imageUrls,
        backgroundImage: backgroundImage,
        isNotice: isNotice,
        likes: likes,
        youtubeUrl: youtubeUrl,
      );
} 