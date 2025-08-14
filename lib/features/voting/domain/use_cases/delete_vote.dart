import 'package:dartz/dartz.dart';
import '../../../../core/errors/voting_failure.dart';
import '../repositories/voting_repository.dart';

/// 투표 삭제 UseCase
class DeleteVote {
  final VotingRepository repository;

  DeleteVote({required this.repository});

  Future<Either<VotingFailure, Unit>> call({
    required String voteId,
    required String userId,
  }) => repository.deleteVote(
    voteId: voteId,
    userId: userId,
  );
}