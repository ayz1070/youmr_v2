import '../repositories/voting_repository.dart';

/// 투표 실행 UseCase
class SubmitVotes {
  final VotingRepository repository;

  SubmitVotes(this.repository);

  Future<void> call({required String userId, required List<String> voteIds}) =>
      repository.submitVotes(userId: userId, voteIds: voteIds);
} 