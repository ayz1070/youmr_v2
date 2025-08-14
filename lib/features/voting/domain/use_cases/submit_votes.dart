import 'package:dartz/dartz.dart';
import '../../../../core/errors/voting_failure.dart';
import '../repositories/voting_repository.dart';

/// 투표 실행 UseCase
class SubmitVotes {
  final VotingRepository repository;

  SubmitVotes({required this.repository});

  Future<Either<VotingFailure, Unit>> call({required String userId, required List<String> voteIds}) =>
      repository.submitVotes(userId: userId, voteIds: voteIds);
} 