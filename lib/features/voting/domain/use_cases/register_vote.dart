import '../repositories/voting_repository.dart';

/// 곡 등록 UseCase
class RegisterVote {
  final VotingRepository repository;

  RegisterVote(this.repository);

  Future<void> call({
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