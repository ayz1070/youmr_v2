import '../repositories/voting_repository.dart';

/// 일일 피크 획득 UseCase
class GetDailyPick {
  final VotingRepository repository;

  GetDailyPick(this.repository);

  Future<void> call({required String userId}) =>
      repository.getDailyPick(userId: userId);
} 