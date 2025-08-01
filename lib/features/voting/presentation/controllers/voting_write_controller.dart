import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/constants/firestore_constants.dart';

/// 투표 작성 페이지의 비즈니스 로직을 담당하는 컨트롤러
class VotingWriteController extends ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController artistController = TextEditingController();
  final TextEditingController youtubeController = TextEditingController();
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// 로딩 상태 변경
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// 컨트롤러들 해제
  @override
  void dispose() {
    titleController.dispose();
    artistController.dispose();
    youtubeController.dispose();
    super.dispose();
  }

  /// 투표 등록 로직
  Future<void> registerVote() async {
    setLoading(true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('로그인 필요');
      
      final userDoc = await FirebaseFirestore.instance
          .collection(FirestoreConstants.usersCollection)
          .doc(user.uid)
          .get();
      final userData = userDoc.data() ?? {};
      
      await FirebaseFirestore.instance.collection(FirestoreConstants.votesCollection).add({
        FirestoreConstants.voteTitle: titleController.text.trim(),
        FirestoreConstants.voteArtist: artistController.text.trim(),
        FirestoreConstants.voteYoutubeUrl: youtubeController.text.trim(),
        FirestoreConstants.voteCount: 0,
        FirestoreConstants.voteCreatedAt: Timestamp.now(),
        FirestoreConstants.voteCreatedBy: user.uid,
        'authorNickname': userData[FirestoreConstants.nickname] ?? '',
        'authorProfileUrl': userData[FirestoreConstants.profileImageUrl] ?? '',
      });
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  /// 폼 유효성 검사
  bool validateForm(GlobalKey<FormState> formKey) {
    return formKey.currentState?.validate() ?? false;
  }
} 