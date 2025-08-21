import 'package:dartz/dartz.dart';
import '../../../../core/errors/voting_failure.dart';
import '../entities/vote.dart';
import '../repositories/voting_repository.dart';

class GetTopVotesPaginated {
  final VotingRepository repository;

  GetTopVotesPaginated({required this.repository});

  Future<Either<VotingFailure, List<Vote>>> call({
    required int limit,
    String? lastDocumentId,
  }) => repository.getTopVotesPaginated(
    limit: limit,
    lastDocumentId: lastDocumentId,
  );
}