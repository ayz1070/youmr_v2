import 'package:dartz/dartz.dart';
import '../../../../core/errors/voting_failure.dart';
import '../repositories/voting_repository.dart';

/// 일일 피크 획득 UseCase
class GetDailyPick {
  final VotingRepository repository;

  GetDailyPick(this.repository);

  Future<Either<VotingFailure, Unit>> call({required String userId}) =>
      repository.getDailyPick(userId: userId);
} 