import '../entities/vote.dart';
import '../entities/user_vote.dart';

/// 투표 관련 도메인 레포지토리 인터페이스
abstract class VotingRepository {
  /// 상위 10개 곡 실시간 조회
  Stream<List<Vote>> getTopVotes();

  /// 투표 실행
  Future<void> submitVotes({
    required String userId,
    required List<String> voteIds,
  });

  /// 일일 피크 획득
  Future<void> getDailyPick({required String userId});

  /// 곡 등록
  Future<void> registerVote({
    required String title,
    required String artist,
    String? youtubeUrl,
    required String createdBy,
  });
} 