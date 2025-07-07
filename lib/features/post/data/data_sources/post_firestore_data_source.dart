import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/post_entity.dart';

/// 게시글 Firestore 데이터소스
class PostFirestoreDataSource {
  final _collection = FirebaseFirestore.instance.collection('posts');

  /// 게시글 목록 페이징 조회
  Future<List<PostEntity>> fetchPosts({
    String? category,
    DocumentSnapshot? startAfter,
    int limit = 20,
  }) async {
    Query<Map<String, dynamic>> query = _collection.orderBy('createdAt', descending: true);
    if (category != null && category != '전체') {
      query = query.where('category', isEqualTo: category);
    }
    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }
    final snapshot = await query.limit(limit).get();
    return snapshot.docs.map((d) => PostEntity.fromJson({...d.data(), 'id': d.id})).toList();
  }

  /// 게시글 상세 조회
  Future<PostEntity> fetchPostDetail(String postId) async {
    final doc = await _collection.doc(postId).get();
    if (!doc.exists) throw Exception('게시글이 존재하지 않습니다.');
    return PostEntity.fromJson({...doc.data()!, 'id': doc.id});
  }

  /// 게시글 저장(작성/수정)
  Future<void> savePost(PostEntity post) async {
    final data = post.toJson();
    data.remove('id');
    if (post.id.isEmpty) {
      // 신규 작성
      await _collection.add(data);
    } else {
      // 수정
      await _collection.doc(post.id).set(data, SetOptions(merge: true));
    }
  }

  /// 게시글 삭제
  Future<void> deletePost(String postId) async {
    await _collection.doc(postId).delete();
  }

  /// 게시글 작성
  Future<void> createPost({
    required String title,
    required String content,
    required String category,
    required String authorId,
    required String authorNickname,
    required String authorProfileUrl,
    String? youtubeUrl,
  }) async {
    await _collection.add({
      'title': title,
      'content': content,
      'category': category,
      'authorId': authorId,
      'authorNickname': authorNickname,
      'authorProfileUrl': authorProfileUrl,
      'youtubeUrl': youtubeUrl ?? '',
      'likes': [],
      'likesCount': 0,
      'isNotice': false,
      'isDeleted': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
} 