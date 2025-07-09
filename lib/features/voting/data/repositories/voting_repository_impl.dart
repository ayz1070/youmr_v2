import '../../domain/entities/vote.dart';
import '../../domain/repositories/voting_repository.dart';
import '../data_sources/voting_firestore_data_source.dart';
import '../dtos/vote_dto.dart';

/// 투표 관련 레포지토리 구현체 (DataSource 위임)
class VotingRepositoryImpl implements VotingRepository {
  final VotingFirestoreDataSource dataSource;

  VotingRepositoryImpl({required this.dataSource});

  @override
  Stream<List<Vote>> getTopVotes() {
    // Firestore 데이터 소스에서 상위 10개 곡 실시간 조회 후 VoteDto로 변환 후 도메인 모델로 변환
    return dataSource.topVotesStream().map(
      (list) => list.map((json) => VoteDto.fromJson(json).toDomain()).toList(),
    );
  }

  @override
  Future<void> submitVotes({required String userId, required List<String> voteIds}) async {
    // Firestore 데이터 소스에 투표 배치 처리 위임
    await dataSource.batchSubmitVotes(userId: userId, voteIds: voteIds);
  }

  @override
  Future<void> getDailyPick({required String userId}) async {
    // Firestore 데이터 소스에 일일 피크 획득 위임
    await dataSource.getDailyPick(userId: userId);
  }

  @override
  Future<void> registerVote({
    required String title,
    required String artist,
    String? youtubeUrl,
    required String createdBy,
  }) async {
    // Firestore 데이터 소스에 곡 등록 위임
    await dataSource.registerVote(
      title: title,
      artist: artist,
      youtubeUrl: youtubeUrl,
      createdBy: createdBy,
    );
  }
} 