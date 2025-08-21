import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youmr_v2/core/constants/app_logger.dart';
import 'package:youmr_v2/core/constants/firestore_constants.dart';
import 'package:youmr_v2/core/constants/post_constants.dart';
import 'package:youmr_v2/features/post/data/data_sources/post_data_source.dart';
import '../dtos/post_dto.dart';

/// Firestore에서 게시글과 좋아요 관련 데이터를 처리하는 데이터 소스
/// - 외부 데이터 통신만 담당, 예외 가공/로깅/Failure 변환 금지
class PostFirestoreDataSource implements PostDataSource {
  /// 게시글 컬렉션 참조
  final CollectionReference<Map<String, dynamic>> _collection =
      FirebaseFirestore.instance.collection(
        FirestoreConstants.postsCollection,
      );

  /// 게시글 상세 정보 조회
  /// [postId]: 게시글 ID
  /// 반환: 게시글 DTO 또는 null
  @override
  Future<PostDto?> fetchPostById(String postId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> doc = await _collection
          .doc(postId)
          .get();

      if (!doc.exists) return null;

      return PostDto.fromJson(doc.data()!, documentId: doc.id);
    } catch (e) {
      AppLogger.e("게시글 상세 조회 실패: $e");
      return null;
    }
  }

  /// 게시글 상세 정보 실시간 스트림 조회
  /// [postId]: 게시글 ID
  /// 반환: 실시간 업데이트되는 게시글 DTO 스트림
  @override
  Stream<PostDto?> getPostStream(String postId) {
    try {
      return _collection.doc(postId).snapshots().map((doc) {
        if (!doc.exists) return null;
        return PostDto.fromJson(doc.data()!, documentId: doc.id);
      });
    } catch (e) {
      AppLogger.e("게시글 실시간 스트림 조회 실패: $e");
      return Stream.value(null);
    }
  }

  /// 게시글 목록 불러오기 (일회성)
  /// [category]: 카테고리(전체/null이면 전체)
  /// [startAfter]: 페이징용 마지막 문서
  /// [limit]: 한 번에 불러올 개수(기본 20)
  /// 반환: 게시글 DTO 리스트
  @override
  Future<List<PostDto>> fetchPosts({
    String? category,
    DocumentSnapshot? startAfter,
    int limit = 20,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _collection.orderBy(
        'createdAt',
        descending: true,
      );
      if (category != null && category != PostConstants.allCategory) {
        query = query.where('category', isEqualTo: category);
      }
      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }
      
      AppLogger.i("게시글 조회 쿼리 실행 - 카테고리: $category, 제한: $limit");
      
      final QuerySnapshot<Map<String, dynamic>> snapshot = await query
          .limit(limit)
          .get();

      AppLogger.i("게시글 조회 완료 - 총 문서 개수: ${snapshot.docs.length}");
      
      // 문서를 PostDto로 변환
      final postDtos = <PostDto>[];
      for (int i = 0; i < snapshot.docs.length; i++) {
        try {
          final doc = snapshot.docs[i];
          final postDto = PostDto.fromJson(doc.data(), documentId: doc.id);
          postDtos.add(postDto);
          AppLogger.i("문서 $i PostDto 변환 성공");
        } catch (e) {
          AppLogger.e("문서 $i PostDto 변환 실패: $e");
        }
      }

      return postDtos;
    } catch (e, stackTrace) {
      AppLogger.e("게시글 조회 실패: $e");
      AppLogger.e("스택 트레이스: $stackTrace");
      rethrow;
    }
  }

  /// 게시글 목록 실시간 스트림 (좋아요 등 실시간 업데이트용)
  /// [category]: 카테고리(전체/null이면 전체)
  /// [limit]: 한 번에 불러올 개수(기본 20)
  /// 반환: 게시글 DTO 스트림
  @override
  Stream<List<PostDto>> fetchPostsStream({
    String? category,
    int limit = 20,
  }) {
    try {
      Query<Map<String, dynamic>> query = _collection.orderBy(
        'createdAt',
        descending: true,
      );
      if (category != null && category != PostConstants.allCategory) {
        query = query.where('category', isEqualTo: category);
      }

      AppLogger.i("게시글 스트림 쿼리 설정 - 카테고리: $category, 제한: $limit");
      
      return query.limit(limit).snapshots().map((snapshot) {
        AppLogger.i("게시글 스트림 업데이트 - 총 문서 개수: ${snapshot.docs.length}");
        
        // 문서를 PostDto로 변환
        final postDtos = <PostDto>[];
        for (int i = 0; i < snapshot.docs.length; i++) {
          try {
            final doc = snapshot.docs[i];
            final postDto = PostDto.fromJson(doc.data(), documentId: doc.id);
            postDtos.add(postDto);
            AppLogger.i("스트림 문서 $i PostDto 변환 성공");
          } catch (e) {
            AppLogger.e("스트림 문서 $i PostDto 변환 실패: $e");
          }
        }
        
        return postDtos;
      });
    } catch (e, stackTrace) {
      AppLogger.e("게시글 스트림 쿼리 설정 실패: $e");
      AppLogger.e("스택 트레이스: $stackTrace");
      rethrow;
    }
  }

  /// 공지글 목록 조회
  /// [limit]: 조회할 공지글 개수
  /// 반환: 공지글 DTO 리스트
  @override
  Future<List<PostDto>> fetchNotices({
    int limit = 3,
  }) async {
    try {
      AppLogger.i("공지글 조회 시작 - 제한: $limit");
      
      final QuerySnapshot<Map<String, dynamic>> noticeSnap = await _collection
          .where('isNotice', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();

      AppLogger.i("공지글 조회 완료 - 총 문서 개수: ${noticeSnap.docs.length}");
      
      // 문서를 PostDto로 변환
      final noticeDtos = <PostDto>[];
      for (int i = 0; i < noticeSnap.docs.length; i++) {
        try {
          final doc = noticeSnap.docs[i];
          final postDto = PostDto.fromJson(doc.data(), documentId: doc.id);
          noticeDtos.add(postDto);
          AppLogger.i("공지글 $i PostDto 변환 성공");
        } catch (e) {
          AppLogger.e("공지글 $i PostDto 변환 실패: $e");
        }
      }

      return noticeDtos;
    } catch (e, stackTrace) {
      AppLogger.e("공지글 조회 실패: $e");
      AppLogger.e("스택 트레이스: $stackTrace");
      return [];
    }
  }

  /// 최신 공지글 스트림 조회
  /// [limit]: 조회할 공지글 개수
  /// 반환: 최신 공지글 DTO 스트림
  @override
  Stream<List<PostDto>> fetchLatestNoticeStream({int limit = 1}) {
    try {
      AppLogger.i("최신 공지글 스트림 설정 - 제한: $limit");
      
      return _collection
          .where('isNotice', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .snapshots()
          .map((snapshot) {
            AppLogger.i("최신 공지글 스트림 업데이트 - 총 문서 개수: ${snapshot.docs.length}");
            
            // 문서를 PostDto로 변환
            final noticeDtos = <PostDto>[];
            for (int i = 0; i < snapshot.docs.length; i++) {
              try {
                final doc = snapshot.docs[i];
                final postDto = PostDto.fromJson(doc.data(), documentId: doc.id);
                noticeDtos.add(postDto);
                AppLogger.i("최신 공지글 스트림 $i PostDto 변환 성공");
              } catch (e) {
                AppLogger.e("최신 공지글 스트림 $i PostDto 변환 실패: $e");
              }
            }
            
            return noticeDtos;
          });
    } catch (e, stackTrace) {
      AppLogger.e("최신 공지글 스트림 설정 실패: $e");
      AppLogger.e("스택 트레이스: $stackTrace");
      rethrow;
    }
  }

  /// 게시글 삭제
  /// [postId]: 삭제할 게시글 ID
  @override
  Future<void> deletePost(String postId) async {
    await _collection.doc(postId).delete();
  }

  /// 게시글 공지 지정/해제
  /// [postId]: 게시글 ID
  /// [isNotice]: 공지 여부
  @override
  Future<void> toggleNotice(String postId, bool isNotice) async {
    await _collection.doc(postId).update({'isNotice': isNotice});
  }

  /// 게시글 생성
  /// [postData]: 생성할 게시글 데이터
  /// 반환: 생성된 게시글 ID
  @override
  Future<String> createPost(Map<String, dynamic> postData) async {
    try {
      final DocumentReference<Map<String, dynamic>> docRef = await _collection
          .add(postData);
      return docRef.id;
    } catch (e) {
      throw Exception('게시글 생성에 실패했습니다: $e');
    }
  }

  /// 게시글의 좋아요 정보 조회
  /// [postId]: 게시글 ID
  /// 반환: 좋아요 정보 (likes 배열, likeCount)
  @override
  Future<Map<String, dynamic>> fetchLikeInfo(String postId) async {
    final DocumentSnapshot<Map<String, dynamic>> doc = await _collection
        .doc(postId)
        .get();

    final data = doc.data() ?? {};
    return {
      'likes': List<String>.from(data['likes'] ?? []),
      'likeCount': data['likeCount'] ?? 0,
    };
  }

  /// 좋아요 토글 처리 (트랜잭션 사용)
  /// [postId]: 게시글 ID
  /// [userId]: 사용자 ID
  /// [isLiked]: 현재 좋아요 상태 (true: 좋아요됨, false: 좋아요 안됨)
  /// 반환: 새로운 좋아요 상태 (true: 좋아요됨, false: 좋아요 안됨)
  @override
  Future<bool> toggleLike(String postId, String userId, bool isLiked) async {
    try {
      final DocumentReference<Map<String, dynamic>> ref = _collection.doc(
        postId,
      );

      await FirebaseFirestore.instance.runTransaction((tx) async {
        final snap = await tx.get(ref);
        final likes = List<String>.from(snap['likes'] ?? []);
        final likeCount = snap['likeCount'] ?? 0;

        if (isLiked) {
          // 좋아요 취소
          likes.remove(userId);
          tx.update(ref, {'likes': likes, 'likeCount': likeCount - 1});
        } else {
          // 좋아요 추가
          likes.add(userId);
          tx.update(ref, {'likes': likes, 'likeCount': likeCount + 1});
        }
      });

      // 새로운 좋아요 상태 반환 (isLiked의 반대)
      return !isLiked;
    } catch (e) {
      AppLogger.e("좋아요 토글 처리 실패: $e");
      return false;
    }
  }

  /// 게시글의 좋아요 상태 확인
  /// [postId]: 게시글 ID
  /// [userId]: 사용자 ID
  /// 반환: 좋아요 여부
  @override
  Future<bool> checkLikeStatus(String postId, String userId) async {
    final likeInfo = await fetchLikeInfo(postId);
    final likes = likeInfo['likes'] as List<String>;
    return likes.contains(userId);
  }
}
