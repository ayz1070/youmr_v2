import '../entities/vote.dart';
import '../repositories/voting_repository.dart';

/// 상위 10개 곡 실시간 조회 UseCase
class GetTopVotes {
  final VotingRepository repository;

  GetTopVotes(this.repository);

  Stream<List<Vote>> call() => repository.getTopVotes();
} 