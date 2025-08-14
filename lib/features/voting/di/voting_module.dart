import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Domain imports
import '../domain/repositories/voting_repository.dart';
import '../domain/entities/vote.dart';
import '../domain/use_cases/register_vote.dart';
import '../domain/use_cases/submit_votes.dart';
import '../domain/use_cases/get_daily_pick.dart';
import '../domain/use_cases/get_top_votes.dart';
import '../domain/use_cases/delete_vote.dart';
import '../domain/use_cases/get_top_votes_paginated.dart';

// Data imports
import '../data/data_sources/voting_data_source.dart';
import '../data/data_sources/voting_firestore_data_source.dart';
import '../data/repositories/voting_repository_impl.dart';
import '../presentation/providers/notifiers/voting_notifier.dart';
import '../presentation/providers/notifiers/voting_pagination_notifier.dart';
import '../presentation/providers/notifiers/voting_write_notifier.dart';
import '../presentation/providers/states/voting_pagination_state.dart';
import '../presentation/providers/states/voting_state.dart';
import '../presentation/providers/states/voting_write_state.dart';

/// Firestore 인스턴스 제공
final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

/// VotingDataSource 제공 (Firestore 구현체)
final votingDataSourceProvider = Provider<VotingDataSource>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return VotingFirestoreDataSource(firestore: firestore);
});

/// VotingRepository 제공 (구현체)
final votingRepositoryProvider = Provider<VotingRepository>((ref) {
  final dataSource = ref.watch(votingDataSourceProvider);

  return VotingRepositoryImpl(dataSource: dataSource);
});

/// UseCase 제공
final registerVoteUseCaseProvider = Provider<RegisterVote>((ref) {
  final repository = ref.watch(votingRepositoryProvider);
  return RegisterVote(repository: repository);
});

final submitVotesUseCaseProvider = Provider<SubmitVotes>((ref) {
  final repository = ref.watch(votingRepositoryProvider);
  return SubmitVotes(repository: repository);
});

final getDailyPickUseCaseProvider = Provider<GetDailyPick>((ref) {
  final repository = ref.watch(votingRepositoryProvider);
  return GetDailyPick(repository: repository);
});

final getTopVotesUseCaseProvider = Provider<GetTopVotes>((ref) {
  final repository = ref.watch(votingRepositoryProvider);
  return GetTopVotes(repository: repository);
});


final getTopVotesPaginatedUseCaseProvider = Provider<GetTopVotesPaginated>((ref) {
  final repository = ref.watch(votingRepositoryProvider);
  return GetTopVotesPaginated(repository: repository);
});



final deleteVoteUseCaseProvider = Provider<DeleteVote>((ref) {
  final repository = ref.watch(votingRepositoryProvider);
  return DeleteVote(repository: repository);
});



/// 투표 작성 Provider
final votingWriteProvider = StateNotifierProvider<VotingWriteNotifier, VotingWriteState>((ref) {
  return VotingWriteNotifier(
    registerVoteUseCase: ref.read(registerVoteUseCaseProvider),
  );
});

/// 투표 상태 Provider (곡 목록, 피크, 선택, 투표/피크 획득 등 관리)
final votingProvider = StateNotifierProvider<VotingNotifier, VotingState>((ref) {
  return VotingNotifier(
    getTopVotesUseCase: ref.read(getTopVotesUseCaseProvider),
    submitVotesUseCase: ref.read(submitVotesUseCaseProvider),
    getDailyPickUseCase: ref.read(getDailyPickUseCaseProvider),
    registerVoteUseCase: ref.read(registerVoteUseCaseProvider),
  );
});




/// 페이징된 투표 목록 Provider
final votingPaginationProvider = StateNotifierProvider<VotingPaginationNotifier, VotingPaginationState>((ref) {
  print('votingPaginationProvider 생성 시작');
  
  final submitVotesUseCase = ref.read(submitVotesUseCaseProvider);
  final getDailyPickUseCase = ref.read(getDailyPickUseCaseProvider);
  final getTopVotesPaginatedUseCase = ref.read(getTopVotesPaginatedUseCaseProvider);
  final deleteVoteUseCase = ref.read(deleteVoteUseCaseProvider);
  
  print('UseCase들 주입 완료');
  
  final notifier = VotingPaginationNotifier(
    submitVotesUseCase: submitVotesUseCase,
    getDailyPickUseCase: getDailyPickUseCase,
    getTopVotesPaginatedUseCase: getTopVotesPaginatedUseCase,
    deleteVoteUseCase: deleteVoteUseCase,
    ref: ref,
  );
  
  print('VotingPaginationNotifier 생성 완료');
  return notifier;
});

/// 상위 투표 목록 스트림 Provider
final topVotesStreamProvider = StreamProvider<List<Vote>>((ref) {
  final useCase = ref.watch(getTopVotesUseCaseProvider);
  return useCase().map((either) => either.fold(
    (failure) => throw failure,
    (votes) => votes,
  ));
});


