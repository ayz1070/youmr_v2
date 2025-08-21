import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youmr_v2/features/post/domain/entities/post.dart';
import 'package:youmr_v2/features/post/domain/repositories/post_repository.dart';
import 'package:youmr_v2/features/post/domain/use_cases/check_post_permission.dart';
import 'package:youmr_v2/features/post/presentation/providers/states/post_detail_state.dart';
import 'dart:async';

/// 게시글 상세 페이지 비즈니스 로직 관리
/// - 클린 아키텍처 원칙에 따라 data layer를 통해 데이터 처리
class PostDetailNotifier extends StateNotifier<PostDetailState> {
  final PostRepository _postRepository;
  final CheckPostPermission _checkPostPermission;
  StreamSubscription<Post?>? _postSubscription;

  /// 생성자
  PostDetailNotifier({
    required PostRepository postRepository,
    required CheckPostPermission checkPostPermission,
  })  : _postRepository = postRepository,
        _checkPostPermission = checkPostPermission,
        super(const PostDetailState());

  /// 게시글 정보 불러오기 (실시간 스트림 지원)
  Future<void> fetchPost(String postId) async {
    // 기존 구독 해제
    _postSubscription?.cancel();
    
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Repository를 통해 게시글 정보 조회
      final result = await _postRepository.fetchPostById(postId);
      
      result.fold(
        (failure) {
          state = state.copyWith(
            error: failure.message,
            isLoading: false,
          );
        },
        (post) {
          // YouTube 컨트롤러 초기화
          YoutubePlayerController? ytController;
          if (post.youtubeUrl.isNotEmpty) {
            final String? videoId = YoutubePlayer.convertUrlToId(post.youtubeUrl);
            if (videoId != null) {
              ytController = YoutubePlayerController(
                initialVideoId: videoId,
                flags: const YoutubePlayerFlags(autoPlay: false),
              );
            }
          }
          
          state = state.copyWith(
            post: post,
            ytController: ytController,
            isLoading: false,
          );
          
          // 실시간 업데이트를 위한 스트림 구독 시작
          _startRealtimeUpdates(postId);
        },
      );
    } catch (e) {
      state = state.copyWith(
        error: '게시글을 불러오지 못했습니다.',
        isLoading: false,
      );
    }
  }

  /// 실시간 업데이트를 위한 스트림 구독 시작
  void _startRealtimeUpdates(String postId) {
    // Firestore 실시간 리스너 설정
    _postSubscription = _postRepository.getPostStream(postId).listen(
      (post) {
        // 게시글 데이터가 업데이트되면 상태 업데이트
        if (post != null) {
          state = state.copyWith(post: post);
        }
      },
      onError: (error) {
        // 에러 발생 시 로깅만 하고 상태는 변경하지 않음
        debugPrint('실시간 업데이트 에러: $error');
      },
    );
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
      final result = await _postRepository.deletePost(postId);
      result.fold(
        (failure) {
          throw Exception(failure.message);
        },
        (_) {
          // 삭제 성공
        },
      );
    } catch (e) {
      throw Exception('게시글 삭제에 실패했습니다.');
    }
  }

  /// 게시글 공지 지정/해제
  Future<void> toggleNotice(String postId, bool isNotice) async {
    try {
      final result = await _postRepository.toggleNotice(postId, isNotice);
      result.fold(
        (failure) {
          throw Exception(failure.message);
        },
        (_) {
          // 공지 변경 성공
        },
      );
      
      // 게시글 정보 새로고침
      await fetchPost(postId);
    } catch (e) {
      throw Exception('공지 변경에 실패했습니다.');
    }
  }

  /// 게시글 수정/삭제 권한 확인
  Future<bool> canEditOrDelete(Post post) async {
    try {
      return await _checkPostPermission(post.authorId);
    } catch (e) {
      return false;
    }
  }

  @override
  void dispose() {
    _postSubscription?.cancel();
    state.ytController?.dispose();
    super.dispose();
  }
}
