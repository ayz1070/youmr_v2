import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../dtos/comment_dto.dart';

/// 댓글 데이터 소스 인터페이스
abstract class CommentDataSource {
  /// 게시글의 댓글 목록 스트림 조회
  Stream<List<CommentDto>> getCommentsStream(String postId);
  
  /// 댓글 생성
  Future<String> createComment(CommentDto comment);
  
  /// 댓글 수정
  Future<void> updateComment(String commentId, String content);
  
  /// 댓글 삭제
  Future<void> deleteComment(String commentId);
  
  /// 댓글 좋아요/취소
  Future<void> toggleLike(String commentId, String userId);
  
  /// 댓글 신고
  Future<void> reportComment(String commentId, String reporterId, String reason);
}

/// 댓글 Firestore 데이터 소스 구현
class CommentFirestoreDataSource implements CommentDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  /// 댓글 컬렉션 이름
  static const String _collectionName = 'comments';
  
  /// 관리자 알림 컬렉션 이름
  static const String _adminNotificationsCollection = 'admin_notifications';

  @override
  Stream<List<CommentDto>> getCommentsStream(String postId) {
    return _firestore
        .collection(_collectionName)
        .where('postId', isEqualTo: postId)
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CommentDto.fromFirestore(doc))
            .toList());
  }

  @override
  Future<String> createComment(CommentDto comment) async {
    try {
      final docRef = await _firestore
          .collection(_collectionName)
          .add(comment.toFirestore());
      
      debugPrint('댓글 생성 완료: ${docRef.id}');
      return docRef.id;
    } catch (e) {
      debugPrint('댓글 생성 실패: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateComment(String commentId, String content) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(commentId)
          .update({'content': content});
      
      debugPrint('댓글 수정 완료: $commentId');
    } catch (e) {
      debugPrint('댓글 수정 실패: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteComment(String commentId) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(commentId)
          .delete();
      
      debugPrint('댓글 삭제 완료: $commentId');
    } catch (e) {
      debugPrint('댓글 삭제 실패: $e');
      rethrow;
    }
  }

  @override
  Future<void> toggleLike(String commentId, String userId) async {
    try {
      await _firestore.runTransaction((transaction) async {
        final docRef = _firestore.collection(_collectionName).doc(commentId);
        final doc = await transaction.get(docRef);
        
        if (!doc.exists) {
          throw Exception('댓글이 존재하지 않습니다.');
        }
        
        final data = doc.data()!;
        final List<String> likes = List<String>.from(data['likes'] ?? []);
        final int likesCount = data['likesCount'] ?? 0;
        
        if (likes.contains(userId)) {
          // 좋아요 취소
          likes.remove(userId);
          transaction.update(docRef, {
            'likes': likes,
            'likesCount': likesCount - 1,
          });
        } else {
          // 좋아요 추가
          likes.add(userId);
          transaction.update(docRef, {
            'likes': likes,
            'likesCount': likesCount + 1,
          });
        }
      });
      
      debugPrint('댓글 좋아요 토글 완료: $commentId');
    } catch (e) {
      debugPrint('댓글 좋아요 토글 실패: $e');
      rethrow;
    }
  }

  @override
  Future<void> reportComment(String commentId, String reporterId, String reason) async {
    try {
      // 댓글 정보 조회
      final commentDoc = await _firestore
          .collection(_collectionName)
          .doc(commentId)
          .get();
      
      if (!commentDoc.exists) {
        throw Exception('댓글이 존재하지 않습니다.');
      }
      
      final commentData = commentDoc.data()!;
      
      // 관리자 알림 생성
      await _firestore
          .collection(_adminNotificationsCollection)
          .add({
        'title': '[신고] 댓글',
        'content': '댓글ID: $commentId\n'
            '내용: ${commentData['content'] ?? ''}\n'
            '작성자: ${commentData['authorNickname'] ?? ''}\n'
            '신고자: $reporterId\n'
            '신고 사유: $reason',
        'targetUserTypes': ['admin', 'developer'],
        'sentAt': FieldValue.serverTimestamp(),
        'createdBy': reporterId,
        'type': 'comment_report',
        'targetId': commentId,
      });
      
      debugPrint('댓글 신고 완료: $commentId');
    } catch (e) {
      debugPrint('댓글 신고 실패: $e');
      rethrow;
    }
  }
} 