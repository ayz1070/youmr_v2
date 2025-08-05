import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'comment_dto.freezed.dart';
part 'comment_dto.g.dart';

/// 댓글 DTO
@freezed
class CommentDto with _$CommentDto {
  const factory CommentDto({
    /// 댓글 ID
    required String id,
    
    /// 게시글 ID
    required String postId,
    
    /// 댓글 내용
    required String content,
    
    /// 작성자 ID
    required String authorId,
    
    /// 작성자 닉네임
    required String authorNickname,
    
    /// 작성자 프로필 이미지 URL
    String? authorProfileUrl,
    
    /// 좋아요한 사용자 ID 리스트
    @Default([]) List<String> likes,
    
    /// 좋아요 수
    @Default(0) int likesCount,
    
    /// 생성 시간
    required DateTime createdAt,
    
    /// 서버 생성 시간
    DateTime? serverCreatedAt,
  }) = _CommentDto;

  factory CommentDto.fromJson(Map<String, dynamic> json) => _$CommentDtoFromJson(json);

  /// Firestore 문서에서 DTO 생성
  factory CommentDto.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return CommentDto(
      id: doc.id,
      postId: data['postId'] ?? '',
      content: data['content'] ?? '',
      authorId: data['authorId'] ?? '',
      authorNickname: data['authorNickname'] ?? '',
      authorProfileUrl: data['authorProfileUrl'],
      likes: List<String>.from(data['likes'] ?? []),
      likesCount: data['likesCount'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      serverCreatedAt: data['serverCreatedAt'] != null 
          ? (data['serverCreatedAt'] as Timestamp).toDate() 
          : null,
    );
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
      'likesCount': likesCount,
      'createdAt': Timestamp.fromDate(createdAt),
      'serverCreatedAt': serverCreatedAt != null 
          ? Timestamp.fromDate(serverCreatedAt!) 
          : FieldValue.serverTimestamp(),
    };
  }
} 