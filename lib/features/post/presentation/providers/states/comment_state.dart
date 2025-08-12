import '../../../domain/entities/comment.dart';

/// 댓글 상태
class CommentState {
  final List<Comment> comments;
  final bool isLoading;
  final String? error;

  const CommentState({
    this.comments = const [],
    this.isLoading = false,
    this.error,
  });

  CommentState copyWith({
    List<Comment>? comments,
    bool? isLoading,
    String? error,
  }) {
    return CommentState(
      comments: comments ?? this.comments,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}