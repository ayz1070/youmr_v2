import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youmr_v2/core/constants/firestore_constants.dart';

/// Firestore에서 게시글을 페이징(20개씩)으로 불러오는 데이터 소스
/// - 외부 데이터 통신만 담당, 예외 가공/로깅/Failure 변환 금지
class PostFirestoreDataSource {
  /// 게시글 컬렉션 참조
  final CollectionReference<Map<String, dynamic>> _collection =
      FirebaseFirestore.instance.collection('posts'); // 컬렉션명 상수화 권장

  /// 게시글 목록 불러오기 (일회성)
  /// [category]: 카테고리(전체/null이면 전체)
  /// [startAfter]: 페이징용 마지막 문서
  /// [limit]: 한 번에 불러올 개수(기본 20)
  /// 반환: 게시글 문서 리스트
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchPosts({
    String? category,
    DocumentSnapshot? startAfter,
    int limit = 20,
  }) async {
    Query<Map<String, dynamic>> query =
        _collection.orderBy(FirestoreConstants.voteCreatedAt, descending: true);
    if (category != null && category != '전체') {
      query = query.where('category', isEqualTo: category); // 필드명 상수화 권장
    }
    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }
    final QuerySnapshot<Map<String, dynamic>> snapshot = await query.limit(limit).get();
    return snapshot.docs;
  }

  /// 게시글 목록 실시간 스트림 (좋아요 등 실시간 업데이트용)
  /// [category]: 카테고리(전체/null이면 전체)
  /// [limit]: 한 번에 불러올 개수(기본 20)
  /// 반환: 게시글 문서 스트림
  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchPostsStream({
    String? category,
    int limit = 20,
  }) {
    Query<Map<String, dynamic>> query =
        _collection.orderBy(FirestoreConstants.voteCreatedAt, descending: true);
    if (category != null && category != '전체') {
      query = query.where('category', isEqualTo: category);
    }
    return query.limit(limit).snapshots().map((snapshot) => snapshot.docs);
  }
} 