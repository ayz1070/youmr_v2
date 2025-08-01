import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_detail_provider.freezed.dart';

/// 게시글 상세 페이지 상태
@freezed
class PostDetailState with _$PostDetailState {
  const factory PostDetailState({
    @Default(false) bool isLoading,
    @Default(false) bool isCommentSheetOpen,
    String? error,
    String? editCommentId,
    String? editContent,
    DocumentSnapshot<Map<String, dynamic>>? post,
    YoutubePlayerController? ytController,
  }) = _PostDetailState;
}

/// 게시글 상세 페이지 비즈니스 로직 관리
class PostDetailNotifier extends StateNotifier<PostDetailState> {
  PostDetailNotifier() : super(const PostDetailState());

  /// 게시글 정보 불러오기
  Future<void> fetchPost(String postId) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .get();
      
      if (!doc.exists) {
        throw Exception('게시글이 존재하지 않습니다.');
      }
      
      final Map<String, dynamic>? data = doc.data();
      
      // YouTube 컨트롤러 초기화
      YoutubePlayerController? ytController;
      if (data != null && data['youtubeUrl'] != null && data['youtubeUrl'] != '') {
        final String? videoId = YoutubePlayer.convertUrlToId(data['youtubeUrl']);
        if (videoId != null) {
          ytController = YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(autoPlay: false),
          );
        }
      }
      
      state = state.copyWith(
        post: doc,
        ytController: ytController,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: '게시글을 불러오지 못했습니다.',
        isLoading: false,
      );
    }
  }

  /// 댓글 수정 모드 설정
  void setEditComment(String commentId, String content) {
    state = state.copyWith(
      editCommentId: commentId,
      editContent: content,
    );
  }

  /// 댓글 수정 모드 해제
  void clearEditComment() {
    state = state.copyWith(
      editCommentId: null,
      editContent: null,
    );
  }

  /// 댓글 바텀시트 열기/닫기
  void toggleCommentSheet(bool isOpen) {
    state = state.copyWith(isCommentSheetOpen: isOpen);
  }

  /// 게시글 삭제
  Future<void> deletePost(String postId) async {
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .delete();
    } catch (e) {
      throw Exception('게시글 삭제에 실패했습니다.');
    }
  }

  /// 게시글 공지 지정/해제
  Future<void> toggleNotice(String postId, bool isNotice) async {
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .update({'isNotice': !isNotice});
      
      // 게시글 정보 새로고침
      await fetchPost(postId);
    } catch (e) {
      throw Exception('공지 변경에 실패했습니다.');
    }
  }

  /// 게시글 수정/삭제 권한 확인
  bool canEditOrDelete(Map<String, dynamic> post) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final userType = FirebaseAuth.instance.currentUser?.displayName; // 임시로 displayName 사용
    
    return post['authorId'] == uid ||
        (userType == 'admin' || userType == 'developer');
  }

  @override
  void dispose() {
    state.ytController?.dispose();
    super.dispose();
  }
}

/// PostDetailNotifier Provider
final postDetailProvider = StateNotifierProvider.family<PostDetailNotifier, PostDetailState, String>(
  (ref, postId) {
    final notifier = PostDetailNotifier();
    // 초기 데이터 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifier.fetchPost(postId);
    });
    return notifier;
  },
); 