import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:youmr_v2/core/errors/voting_failure.dart';
import 'package:youmr_v2/features/voting/data/data_sources/voting_data_source.dart';
import 'package:youmr_v2/features/voting/data/dtos/vote_dto.dart';
import 'package:youmr_v2/features/voting/domain/entities/vote.dart';
import 'package:youmr_v2/features/voting/domain/repositories/voting_repository.dart';

/// 투표 관련 레포지토리 구현체 (DataSource 위임)
class VotingRepositoryImpl implements VotingRepository {
  final VotingDataSource dataSource;

  VotingRepositoryImpl({required this.dataSource});

  @override
  Stream<Either<VotingFailure, List<Vote>>> getTopVotes() {
    // Firestore 데이터 소스에서 상위 10개 곡 실시간 조회 후 VoteDto로 변환 후 도메인 모델로 변환
    return dataSource.topVotesStream()
        .map((list) => Right<VotingFailure, List<Vote>>(list.map((json) => VoteDto.fromJson(json).toDomain()).toList()))
        .transform(StreamTransformer.fromHandlers(
          handleError: (error, stackTrace, sink) {
            sink.add(Left(VotingNetworkFailure()));
          },
        ));
  }

  @override
  Future<Either<VotingFailure, Unit>> submitVotes({required String userId, required List<String> voteIds}) async {
    try {
      await dataSource.batchSubmitVotes(userId: userId, voteIds: voteIds);
      return const Right(unit);
    } catch (e) {
      if (e.toString().contains('피크')) {
        return Left(VotingPickExceedFailure());
      }
      return Left(VotingNetworkFailure());
    }
  }

  @override
  Future<Either<VotingFailure, Unit>> getDailyPick({required String userId}) async {
    try {
      await dataSource.getDailyPick(userId: userId);
      return const Right(unit);
    } catch (e) {
      if (e.toString().contains('이미')) {
        return Left(VotingAlreadyPickedFailure());
      }
      return Left(VotingNetworkFailure());
    }
  }

  @override
  Future<Either<VotingFailure, Unit>> registerVote({
    required String title,
    required String artist,
    String? youtubeUrl,
    required String createdBy,
  }) async {
    try {
      await dataSource.saveVote(
        title: title,
        artist: artist,
        youtubeUrl: youtubeUrl,
        createdBy: createdBy,
      );
      return const Right(unit);
    } catch (e) {
      if (e.toString().contains('이미 등록')) {
        return Left(VotingAlreadyRegisteredFailure());
      }
      return Left(VotingNetworkFailure());
    }
  }

  @override
  Future<Either<VotingFailure, List<Vote>>> getTopVotesPaginated({
    required int limit,
    String? lastDocumentId,
  }) async {
    try {
      final voteList = await dataSource.fetchTopVotesPaginated(
        limit: limit,
        lastDocumentId: lastDocumentId,
      );
      final votes = voteList.map((json) => VoteDto.fromJson(json).toDomain()).toList();
      return Right(votes);
    } catch (e) {
      return Left(VotingNetworkFailure());
    }
  }

  @override
  Future<Either<VotingFailure, Unit>> deleteVote({
    required String voteId,
    required String userId,
  }) async {
    try {
      await dataSource.deleteVote(voteId: voteId, userId: userId);
      return const Right(unit);
    } catch (e) {
      if (e.toString().contains('권한')) {
        return Left(VotingPermissionFailure());
      }
      return Left(VotingNetworkFailure());
    }
  }
} 