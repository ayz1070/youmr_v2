import 'package:dartz/dartz.dart';
import '../../../../core/errors/voting_failure.dart';
import '../repositories/voting_repository.dart';

/// 곡 등록 UseCase
class RegisterVote {
  final VotingRepository repository;

  RegisterVote(this.repository);

  Future<Either<VotingFailure, Unit>> call({
    required String title,
    required String artist,
    String? youtubeUrl,
    required String createdBy,
  }) =>
      repository.registerVote(
        title: title,
        artist: artist,
        youtubeUrl: youtubeUrl,
        createdBy: createdBy,
      );
} 