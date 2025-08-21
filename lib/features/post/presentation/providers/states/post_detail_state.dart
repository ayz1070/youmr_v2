import 'package:flutter/material.dart';
import 'package:youmr_v2/features/post/domain/entities/post.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// 게시글 상세 페이지 상태
class PostDetailState {
  final bool isLoading;
  final bool isCommentSheetOpen;
  final String? error;
  final String? editCommentId;
  final String? editContent;
  final Post? post;
  final YoutubePlayerController? ytController;

  const PostDetailState({
    this.isLoading = false,
    this.isCommentSheetOpen = false,
    this.error,
    this.editCommentId,
    this.editContent,
    this.post,
    this.ytController,
  });

  /// 상태 복사본 생성
  PostDetailState copyWith({
    bool? isLoading,
    bool? isCommentSheetOpen,
    String? error,
    String? editCommentId,
    String? editContent,
    Post? post,
    YoutubePlayerController? ytController,
  }) {
    return PostDetailState(
      isLoading: isLoading ?? this.isLoading,
      isCommentSheetOpen: isCommentSheetOpen ?? this.isCommentSheetOpen,
      error: error ?? this.error,
      editCommentId: editCommentId ?? this.editCommentId,
      editContent: editContent ?? this.editContent,
      post: post ?? this.post,
      ytController: ytController ?? this.ytController,
    );
  }

  /// 상태 초기화
  PostDetailState reset() {
    return const PostDetailState();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PostDetailState &&
        other.isLoading == isLoading &&
        other.isCommentSheetOpen == isCommentSheetOpen &&
        other.error == error &&
        other.editCommentId == editCommentId &&
        other.editContent == editContent &&
        other.post == post &&
        other.ytController == ytController;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        isCommentSheetOpen.hashCode ^
        error.hashCode ^
        editCommentId.hashCode ^
        editContent.hashCode ^
        post.hashCode ^
        ytController.hashCode;
  }
}
