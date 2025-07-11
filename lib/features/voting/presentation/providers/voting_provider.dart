import 'package:dartz/dartz.dart';
import '../../../../core/errors/voting_failure.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/entities/vote.dart';
import '../../domain/repositories/voting_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// 투표 상태 Provider (곡 목록, 피크, 선택, 투표/피크 획득 등 관리)
final votingProvider = NotifierProvider<VotingProvider, List<Vote>?>(VotingProvider.new);

/// 현재 로그인 사용자의 피크(pick) 개수를 실시간 구독하는 Provider
final pickProvider = StreamProvider<int>((ref) {
  final authUser = ref.watch(authProvider).value;
  if (authUser == null) return const Stream.empty();
  final userDoc = FirebaseFirestore.instance.collection('users').doc(authUser.uid);
  return userDoc.snapshots().map((snap) => (snap.data()?['pick'] ?? 0) as int);
});

class VotingProvider extends Notifier<List<Vote>?> {
  late final VotingRepository _repository;
  List<String> selectedVoteIds = [];
  int pick = 0;

  @override
  List<Vote>? build() {
    _repository = ref.watch(votingRepositoryProvider);
    // 곡 목록 스트림 구독 및 상태 갱신
    _repository.getTopVotes().listen(
      (either) {
        either.fold(
          (failure) => state = null,
          (voteList) => state = voteList,
        );
      },
      onError: (e) {
        state = null; // 에러 발생 시 null로 설정
      },
    );
    return null; // 최초에는 null(로딩/에러)로 시작
  }

  void toggleVote(String voteId) {
    if (selectedVoteIds.contains(voteId)) {
      selectedVoteIds.remove(voteId);
    } else {
      selectedVoteIds.add(voteId);
    }
    // 상태 변경 알림 (shallow copy)
    state = state == null ? null : List<Vote>.from(state!);
  }

  /// 에러 발생 시 VotingFailure 객체를 반환, 성공 시 null 반환
  Future<VotingFailure?> submitVotes(String userId) async {
    final result = await _repository.submitVotes(userId: userId, voteIds: selectedVoteIds);
    return result.fold(
      (failure) => failure,
      (_) {
        selectedVoteIds.clear();
        return null;
      },
    );
  }

  Future<VotingFailure?> getDailyPick(String userId) async {
    final result = await _repository.getDailyPick(userId: userId);
    return result.fold(
      (failure) => failure,
      (_) => null,
    );
  }

  Future<VotingFailure?> registerVote({
    required String title,
    required String artist,
    String? youtubeUrl,
    required String createdBy,
  }) async {
    final result = await _repository.registerVote(
      title: title,
      artist: artist,
      youtubeUrl: youtubeUrl,
      createdBy: createdBy,
    );
    return result.fold(
      (failure) => failure,
      (_) => null,
    );
  }
}

/// VotingRepository Provider (의존성 주입)
final votingRepositoryProvider = Provider<VotingRepository>((ref) {
  throw UnimplementedError('votingRepositoryProvider를 main에서 override해야 합니다.');
}); 