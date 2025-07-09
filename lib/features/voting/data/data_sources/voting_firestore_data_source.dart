import 'package:cloud_firestore/cloud_firestore.dart';

/// 투표 관련 Firestore 데이터 소스
class VotingFirestoreDataSource {
  final FirebaseFirestore _firestore;
  static const String votesCollection = 'votes';
  static const String usersCollection = 'users';
  static const String userVotesCollection = 'userVotes';

  VotingFirestoreDataSource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// 상위 10개 곡 실시간 조회
  Stream<List<Map<String, dynamic>>> topVotesStream() {
    return _firestore
        .collection(votesCollection)
        .orderBy('voteCount', descending: true)
        .limit(10)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList());
  }

  /// 투표 배치 처리 (곡 득표수 증가, userVotes 기록, 피크 차감)
  Future<void> batchSubmitVotes({
    required String userId,
    required List<String> voteIds,
  }) async {
    final batch = _firestore.batch();
    final userRef = _firestore.collection(usersCollection).doc(userId);
    final userSnap = await userRef.get();
    final pick = userSnap.data()?['pick'] ?? 0;

    if (voteIds.length > pick) {
      throw Exception('보유 피크보다 많은 곡을 선택할 수 없습니다.');
    }

    for (final voteId in voteIds) {
      final voteRef = _firestore.collection(votesCollection).doc(voteId);
      batch.update(voteRef, {'voteCount': FieldValue.increment(1)});
      final userVoteRef = _firestore.collection(userVotesCollection).doc();
      batch.set(userVoteRef, {
        'userId': userId,
        'voteId': voteId,
        'votedAt': Timestamp.now(),
      });
    }

    batch.update(userRef, {'pick': pick - voteIds.length});
    await batch.commit();
  }

  /// 일일 피크 획득 (하루 1회 제한)
  Future<void> getDailyPick({required String userId}) async {
    final userRef = _firestore.collection(usersCollection).doc(userId);
    final userSnap = await userRef.get();
    final now = DateTime.now();
    final lastPickDate = userSnap.data()?['lastPickDate']?.toDate();
    final pick = userSnap.data()?['pick'] ?? 0;

    if (lastPickDate == null ||
        !(lastPickDate.year == now.year &&
          lastPickDate.month == now.month &&
          lastPickDate.day == now.day)) {
      await userRef.update({
        'pick': pick + 1,
        'lastPickDate': Timestamp.fromDate(now),
      });
    } else {
      throw Exception('이미 오늘 피크를 받았습니다.');
    }
  }

  /// 곡 등록 (제목+가수 중복 방지)
  Future<void> registerVote({
    required String title,
    required String artist,
    String? youtubeUrl,
    required String createdBy,
  }) async {
    final query = await _firestore
        .collection(votesCollection)
        .where('title', isEqualTo: title)
        .where('artist', isEqualTo: artist)
        .get();
    if (query.docs.isNotEmpty) {
      throw Exception('이미 등록된 곡입니다.');
    }
    await _firestore.collection(votesCollection).add({
      'title': title,
      'artist': artist,
      'youtubeUrl': youtubeUrl,
      'voteCount': 0,
      'createdAt': Timestamp.now(),
      'createdBy': createdBy,
    });
  }
} 