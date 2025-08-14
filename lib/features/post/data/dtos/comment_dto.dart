import 'package:cloud_firestore/cloud_firestore.dart';

/// 댓글 DTO
class CommentDto {
  /// 댓글 ID
  final String id;
  
  /// 게시글 ID
  final String postId;
  
  /// 댓글 내용
  final String content;
  
  /// 작성자 ID
  final String authorId;
  
  /// 작성자 닉네임
  final String authorNickname;
  
  /// 작성자 프로필 이미지 URL
  final String? authorProfileUrl;
  
  /// 좋아요한 사용자 ID 리스트
  final List<String> likes;
  
  /// 좋아요 수
  final int likeCount;
  
  /// 생성 시간
  final DateTime createdAt;
  
  /// 서버 생성 시간
  final DateTime? serverCreatedAt;

  /// 댓글 DTO 생성자
  const CommentDto({
    required this.id,
    required this.postId,
    required this.content,
    required this.authorId,
    required this.authorNickname,
    this.authorProfileUrl,
    this.likes = const [],
    this.likeCount = 0,
    required this.createdAt,
    this.serverCreatedAt,
  });

  /// JSON → CommentDto 변환 (타입 안전성 검증 포함)
  /// [json]: Firestore 문서 데이터
  /// [documentId]: 문서 ID (필드에 id가 없는 경우 사용)
  factory CommentDto.fromJson(Map<String, dynamic> json, {String? documentId}) {
    try {
      // 문서 ID 처리
      final id = documentId ?? json['id']?.toString() ?? '';
      
      // 필드 매핑 및 변환
      final postId = json['postId']?.toString() ?? '';
      final content = json['content']?.toString() ?? '';
      final authorId = json['authorId']?.toString() ?? '';
      final authorNickname = json['authorNickname']?.toString() ?? '';
      final authorProfileUrl = json['authorProfileUrl']?.toString();
      
      // DateTime 변환
      final createdAt = _parseDateTime(json['createdAt']);
      final serverCreatedAt = json['serverCreatedAt'] != null 
          ? _parseDateTime(json['serverCreatedAt']) 
          : null;
      
      // 숫자 및 리스트 필드 변환
      final likeCount = _parseInt(json['likeCount']);
      final likes = _parseStringList(json['likes']);
      
      return CommentDto(
        id: id,
        postId: postId,
        content: content,
        authorId: authorId,
        authorNickname: authorNickname,
        authorProfileUrl: authorProfileUrl,
        likes: likes,
        likeCount: likeCount,
        createdAt: createdAt,
        serverCreatedAt: serverCreatedAt,
      );
      
    } catch (e) {
      throw Exception('CommentDto.fromJson 변환 실패: $e');
    }
  }

  /// Firestore 문서에서 DTO 생성
  factory CommentDto.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return CommentDto.fromJson(data, documentId: doc.id);
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

/// CommentDto 확장 메서드
extension CommentDtoExtension on CommentDto {
  /// Firestore 문서로 변환
  Map<String, dynamic> toFirestore() {
    return {
      'postId': postId,
      'content': content,
      'authorId': authorId,
      'authorNickname': authorNickname,
      'authorProfileUrl': authorProfileUrl,
      'likes': likes,
      'likeCount': likeCount,
      'createdAt': Timestamp.fromDate(createdAt),
      'serverCreatedAt': serverCreatedAt != null 
          ? Timestamp.fromDate(serverCreatedAt!) 
          : FieldValue.serverTimestamp(),
    };
  }
} 