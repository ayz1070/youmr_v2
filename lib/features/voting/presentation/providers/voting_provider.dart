import 'package:riverpod/riverpod.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/entities/vote.dart';
import '../../domain/repositories/voting_repository.dart';
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
      (voteList) {
        state = voteList;
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

  Future<String?> submitVotes(String userId) async {
    try {
      await _repository.submitVotes(userId: userId, voteIds: selectedVoteIds);
      selectedVoteIds.clear();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> getDailyPick(String userId) async {
    try {
      await _repository.getDailyPick(userId: userId);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> registerVote({
    required String title,
    required String artist,
    String? youtubeUrl,
    required String createdBy,
  }) async {
    try {
      await _repository.registerVote(
        title: title,
        artist: artist,
        youtubeUrl: youtubeUrl,
        createdBy: createdBy,
      );
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}

/// VotingRepository Provider (의존성 주입)
final votingRepositoryProvider = Provider<VotingRepository>((ref) {
  throw UnimplementedError('votingRepositoryProvider를 main에서 override해야 합니다.');
}); 