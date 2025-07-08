import 'package:cloud_firestore/cloud_firestore.dart';

/// Firestore에서 게시글을 페이징(20개씩)으로 불러오는 데이터 소스
class PostFirestoreDataSource {
  final _collection = FirebaseFirestore.instance.collection('posts');

  /// 게시글 목록 불러오기
  /// [category]가 null이면 전체, 아니면 해당 카테고리만
  /// [startAfter]는 페이징용 마지막 문서
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchPosts({
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
    return snapshot.docs;
  }
} 