import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youmr_v2/core/constants/firestore_constants.dart';
import 'package:youmr_v2/core/constants/error_messages.dart';
import 'package:youmr_v2/core/constants/app_logger.dart';

/// 투표 관련 Firestore 데이터 소스
class VotingFirestoreDataSource {
  /// Firestore 인스턴스
  final FirebaseFirestore _firestore;

  /// 생성자 - Firestore 인스턴스 주입(테스트 용이성)
  VotingFirestoreDataSource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// 상위 10개 곡 실시간 조회
  /// @return 곡 문서 리스트(Map) 스트림
  Stream<List<Map<String, dynamic>>> topVotesStream() {
    return _firestore
        .collection(FirestoreConstants.votesCollection)
        .orderBy(FirestoreConstants.voteCount, descending: true)
        .limit(10)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) =>
            snapshot.docs
                .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
                    {...doc.data(), 'id': doc.id})
                .toList());
  }

  /// 투표 배치 처리 (곡 득표수 증가, userVotes 기록, 피크 차감)
  /// @param userId 사용자 ID
  /// @param voteIds 투표할 곡 ID 리스트
  Future<void> batchSubmitVotes({
    required String userId,
    required List<String> voteIds,
  }) async {
    final WriteBatch batch = _firestore.batch();
    final DocumentReference<Map<String, dynamic>> userRef =
        _firestore.collection(FirestoreConstants.usersCollection).doc(userId);
    final DocumentSnapshot<Map<String, dynamic>> userSnap = await userRef.get();
    final int pick = userSnap.data()?[FirestoreConstants.pick] ?? 0;

    if (voteIds.length > pick) {
      throw Exception(ErrorMessages.votingPickExceedError);
    }

    for (final String voteId in voteIds) {
      final DocumentReference<Map<String, dynamic>> voteRef = _firestore
          .collection(FirestoreConstants.votesCollection)
          .doc(voteId);
      batch.update(voteRef, {
        FirestoreConstants.voteCount: FieldValue.increment(1),
      });
      final DocumentReference<Map<String, dynamic>> userVoteRef = _firestore
          .collection(FirestoreConstants.userVotesCollection)
          .doc();
      batch.set(userVoteRef, {
        FirestoreConstants.userId: userId,
        'voteId': voteId, // TODO: voteId도 상수화 필요시 추가
        'votedAt': Timestamp.now(),
      });
    }

    batch.update(userRef, {
      FirestoreConstants.pick: pick - voteIds.length,
    });
    await batch.commit();
  }

  /// 일일 피크 획득 (하루 1회 제한)
  /// @param userId 사용자 ID
  Future<void> getDailyPick({required String userId}) async {
    final DocumentReference<Map<String, dynamic>> userRef =
        _firestore.collection(FirestoreConstants.usersCollection).doc(userId);
    final DocumentSnapshot<Map<String, dynamic>> userSnap = await userRef.get();
    final DateTime now = DateTime.now();
    final DateTime? lastPickDate =
        userSnap.data()?[FirestoreConstants.lastPickDate]?.toDate();
    final int pick = userSnap.data()?[FirestoreConstants.pick] ?? 0;

    if (lastPickDate == null ||
        !(lastPickDate.year == now.year &&
            lastPickDate.month == now.month &&
            lastPickDate.day == now.day)) {
      await userRef.update({
        FirestoreConstants.pick: pick + 1,
        FirestoreConstants.lastPickDate: Timestamp.fromDate(now),
      });
    } else {
      throw Exception(ErrorMessages.votingAlreadyPickedError);
    }
  }

  /// 곡 등록 (제목+가수 중복 방지)
  /// @param title 곡 제목
  /// @param artist 아티스트
  /// @param youtubeUrl 유튜브 URL
  /// @param createdBy 등록자 ID
  Future<void> registerVote({
    required String title,
    required String artist,
    String? youtubeUrl,
    required String createdBy,
  }) async {
    final QuerySnapshot<Map<String, dynamic>> query = await _firestore
        .collection(FirestoreConstants.votesCollection)
        .where(FirestoreConstants.voteTitle, isEqualTo: title)
        .where(FirestoreConstants.voteArtist, isEqualTo: artist)
        .get();
    if (query.docs.isNotEmpty) {
      throw Exception(ErrorMessages.votingAlreadyRegisteredError);
    }
    
    // 사용자 정보 가져오기
    final userDoc = await _firestore
        .collection(FirestoreConstants.usersCollection)
        .doc(createdBy)
        .get();
    final userData = userDoc.data() ?? {};
    
    await _firestore.collection(FirestoreConstants.votesCollection).add({
      FirestoreConstants.voteTitle: title,
      FirestoreConstants.voteArtist: artist,
      FirestoreConstants.voteYoutubeUrl: youtubeUrl,
      FirestoreConstants.voteCount: 0,
      FirestoreConstants.voteCreatedAt: Timestamp.now(),
      FirestoreConstants.voteCreatedBy: createdBy,
      'authorNickname': userData['nickname'] ?? '',
      'authorProfileUrl': userData['profileImageUrl'] ?? '',
    });
  }

  /// 페이징된 상위 곡 조회
  /// @param limit 조회할 개수
  /// @param lastDocumentId 마지막 문서 ID (페이징용)
  /// @return 곡 문서 리스트(Map)
  Future<List<Map<String, dynamic>>> getTopVotesPaginated({
    required int limit,
    String? lastDocumentId,
  }) async {
    try {
      AppLogger.d('getTopVotesPaginated 시작: limit=$limit, lastDocumentId=$lastDocumentId');
      
      Query<Map<String, dynamic>> query = _firestore
          .collection(FirestoreConstants.votesCollection)
          .orderBy(FirestoreConstants.voteCount, descending: true)
          .limit(limit);

      if (lastDocumentId != null) {
        final lastDoc = await _firestore
            .collection(FirestoreConstants.votesCollection)
            .doc(lastDocumentId)
            .get();
        query = query.startAfterDocument(lastDoc);
      }

      final QuerySnapshot<Map<String, dynamic>> snapshot = await query.get();
      final result = snapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
              {...doc.data(), 'id': doc.id})
          .toList();
      
      AppLogger.d('getTopVotesPaginated 성공: ${result.length}개 문서 조회됨');
      return result;
    } catch (e) {
      AppLogger.e('getTopVotesPaginated 실패', error: e);
      rethrow;
    }
  }

  /// 곡 삭제 (작성자만 가능)
  /// @param voteId 삭제할 곡 ID
  /// @param userId 삭제 요청한 사용자 ID
  Future<void> deleteVote({
    required String voteId,
    required String userId,
  }) async {
    final DocumentSnapshot<Map<String, dynamic>> voteDoc = await _firestore
        .collection(FirestoreConstants.votesCollection)
        .doc(voteId)
        .get();

    if (!voteDoc.exists) {
      throw Exception('곡을 찾을 수 없습니다.');
    }

    final voteData = voteDoc.data()!;
    final String createdBy = voteData[FirestoreConstants.voteCreatedBy];

    if (createdBy != userId) {
      throw Exception('삭제 권한이 없습니다.');
    }

    await _firestore
        .collection(FirestoreConstants.votesCollection)
        .doc(voteId)
        .delete();
  }
} 