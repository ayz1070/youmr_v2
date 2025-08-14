

/// 투표 관련 Firestore 데이터 소스
abstract class VotingDataSource {
  /// 상위 10개 곡 실시간 조회
  Stream<List<Map<String, dynamic>>> topVotesStream();

  /// 투표 배치 처리 (곡 득표수 증가, userVotes 기록, 피크 차감)
  Future<void> batchSubmitVotes({
    required String userId,
    required List<String> voteIds,
  });

  /// 일일 피크 획득 (하루 1회 제한)
  /// @param userId 사용자 ID
  Future<void> getDailyPick({required String userId});

  /// 곡 등록 (제목+가수 중복 방지)
  /// @param title 곡 제목
  /// @param artist 아티스트
  /// @param youtubeUrl 유튜브 URL
  /// @param createdBy 등록자 ID
  Future<void> saveVote({
    required String title,
    required String artist,
    String? youtubeUrl,
    required String createdBy,
  });

  /// 페이징된 상위 곡 조회
  /// @param limit 조회할 개수
  /// @param lastDocumentId 마지막 문서 ID (페이징용)
  /// @return 곡 문서 리스트(Map)
  Future<List<Map<String, dynamic>>> fetchTopVotesPaginated({
    required int limit,
    String? lastDocumentId,
  });

  /// 곡 삭제 (작성자만 가능)
  /// @param voteId 삭제할 곡 ID
  /// @param userId 삭제 요청한 사용자 ID
  Future<void> deleteVote({required String voteId, required String userId});
}
