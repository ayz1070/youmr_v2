import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youmr_v2/features/post/domain/use_cases/get_comments_use_case.dart';
import 'package:youmr_v2/features/post/domain/use_cases/create_comment_use_case.dart';
import 'package:youmr_v2/features/post/domain/use_cases/update_comment_use_case.dart';
import 'package:youmr_v2/features/post/domain/use_cases/delete_comment_use_case.dart';
import 'package:youmr_v2/features/post/domain/use_cases/toggle_comment_like_use_case.dart';
import 'package:youmr_v2/features/post/domain/use_cases/report_comment_use_case.dart';

import '../data/data_sources/comment_firestore_data_source.dart';
import '../data/repositories/comment_repository_impl.dart';
import '../domain/repositories/comment_repository.dart';
import '../presentation/providers/notifiers/comment_notifier.dart';
import '../presentation/providers/states/comment_state.dart';


/// Repository Providers
final commentRepositoryProvider = Provider<CommentRepository>((ref) {
  return CommentRepositoryImpl(CommentFirestoreDataSource());
});


/// Use Case Providers
final getCommentsUseCaseProvider = Provider<GetCommentsUseCase>((ref) {
  final repository = ref.read(commentRepositoryProvider);
  return GetCommentsUseCase(repository);
});

final createCommentUseCaseProvider = Provider<CreateCommentUseCase>((ref) {
  final repository = ref.read(commentRepositoryProvider);
  return CreateCommentUseCase(repository);
});

final updateCommentUseCaseProvider = Provider<UpdateCommentUseCase>((ref) {
  final repository = ref.read(commentRepositoryProvider);
  return UpdateCommentUseCase(repository);
});

final deleteCommentUseCaseProvider = Provider<DeleteCommentUseCase>((ref) {
  final repository = ref.read(commentRepositoryProvider);
  return DeleteCommentUseCase(repository);
});

final toggleCommentLikeUseCaseProvider = Provider<ToggleCommentLikeUseCase>((ref) {
  final repository = ref.read(commentRepositoryProvider);
  return ToggleCommentLikeUseCase(repository);
});

final reportCommentUseCaseProvider = Provider<ReportCommentUseCase>((ref) {
  final repository = ref.read(commentRepositoryProvider);
  return ReportCommentUseCase(repository);
});


/// 댓글 Provider
final commentProvider = StateNotifierProvider.family<CommentNotifier, CommentState, String>(
      (ref, postId) => CommentNotifier(
    getComments: ref.read(getCommentsUseCaseProvider),
    createComment: ref.read(createCommentUseCaseProvider),
    updateComment: ref.read(updateCommentUseCaseProvider),
    deleteComment: ref.read(deleteCommentUseCaseProvider),
    toggleLike: ref.read(toggleCommentLikeUseCaseProvider),
    reportComment: ref.read(reportCommentUseCaseProvider),
    postId: postId,
  ),
);


