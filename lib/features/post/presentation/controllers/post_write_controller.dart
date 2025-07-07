import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/use_cases/create_post_use_case.dart';

part 'post_write_controller.freezed.dart';

/// 게시글 작성 상태
@freezed
class PostWriteState with _$PostWriteState {
  const factory PostWriteState({
    @Default(false) bool isLoading,
    String? error,
    bool? success,
  }) = _PostWriteState;
}

/// 게시글 작성 컨트롤러 (AsyncNotifier)
class PostWriteController extends AsyncNotifier<PostWriteState> {
  late final CreatePostUseCase _createPostUseCase;

  @override
  Future<PostWriteState> build() async {
    // DI: 유스케이스 주입 (provider에서 처리)
    return const PostWriteState();
  }

  /// 게시글 작성
  Future<void> createPost({
    required String title,
    required String content,
    required String category,
    required String authorId,
    required String authorNickname,
    required String authorProfileUrl,
    String? youtubeUrl,
  }) async {
    state = const AsyncLoading();
    try {
      await _createPostUseCase(
        title: title,
        content: content,
        category: category,
        authorId: authorId,
        authorNickname: authorNickname,
        authorProfileUrl: authorProfileUrl,
        youtubeUrl: youtubeUrl,
      );
      state = const AsyncData(PostWriteState(success: true));
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
} 