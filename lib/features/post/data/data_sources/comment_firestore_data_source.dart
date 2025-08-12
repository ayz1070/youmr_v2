
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/firestore_constants.dart';
import '../dtos/comment_dto.dart';
import 'comment_data_source.dart';

/// 댓글 Firestore 데이터 소스 구현
class CommentFirestoreDataSource implements CommentDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 댓글 컬렉션 이름
  static const String _collectionName = FirestoreConstants.commentsCollection;

  final CollectionReference<Map<String, dynamic>> _collection =
      FirebaseFirestore.instance.collection(
        FirestoreConstants.commentsCollection,
      );

  /// 관리자 알림 컬렉션 이름
  static const String _adminNotificationsCollection = FirestoreConstants.adminNotificationsCollection;

  @override
  Future<List<CommentDto>> fetchComments(String postId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection(_collectionName)
          .where('postId', isEqualTo: postId)
          .orderBy('createdAt', descending: false)
          .get();

      return snapshot.docs
          .map((doc) => CommentDto.fromFirestore(doc))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<CommentDto>> fetchCommentsStream(String postId) {
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
  Future<CommentDto?> fetchCommentById(String commentId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> doc = await _collection
          .doc(commentId)
          .get();

      if (!doc.exists) return null;

      return CommentDto.fromFirestore(doc);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> createComment(CommentDto comment) async {
    try {
      final docRef = await _collection
          .add(comment.toFirestore());

      return docRef.id;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateComment(String commentId, String content) async {
    try {
      await _collection
          .doc(commentId)
          .update({'content': content});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteComment(String commentId) async {
    try {
      await _collection
          .doc(commentId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> toggleLike(String commentId, String userId) async {
    try {
      bool isLiked = false;
      
      await _firestore.runTransaction((transaction) async {
        final docRef = _collection.doc(commentId);
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
          isLiked = false;
          transaction.update(docRef, {
            'likes': likes,
            'likesCount': likesCount - 1,
          });
        } else {
          // 좋아요 추가
          likes.add(userId);
          isLiked = true;
          transaction.update(docRef, {
            'likes': likes,
            'likesCount': likesCount + 1,
          });
        }
      });

      return isLiked;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> checkLikeStatus(String commentId, String userId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> doc = await _collection
          .doc(commentId)
          .get();

      if (!doc.exists) return false;

      final data = doc.data()!;
      final List<String> likes = List<String>.from(data['likes'] ?? []);
      
      return likes.contains(userId);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> reportComment(String commentId, String reporterId, String reason) async {
    try {
      // 댓글 정보 조회
      final commentDoc = await _collection
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
    } catch (e) {
      rethrow;
    }
  }
}