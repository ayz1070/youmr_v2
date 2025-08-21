import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

/// 댓글 엔티티
@freezed
class Comment with _$Comment {
  const factory Comment({
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
    @Default(0) int likeCount,
    
    /// 생성 시간
    required DateTime createdAt,
    
    /// 서버 생성 시간
    DateTime? serverCreatedAt,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
} 