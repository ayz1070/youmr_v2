import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youmr_v2/core/widgets/primary_app_bar.dart';
import 'package:youmr_v2/core/widgets/app_loading_view.dart';
import '../../di/post_module.dart';
import '../widgets/post_header_image.dart';
import '../widgets/post_form_inputs.dart';
import '../../../main/presentation/pages/main_navigation_page.dart';

/// 게시글 작성 페이지
class PostWritePage extends ConsumerStatefulWidget {
  const PostWritePage({super.key});

  @override
  ConsumerState<PostWritePage> createState() => _PostWritePageState();
}

class _PostWritePageState extends ConsumerState<PostWritePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// 게시글 등록 처리
  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref.read(postWriteProvider.notifier).submitPost();

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('게시글이 등록되었습니다.')));
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const MainNavigationPage(),
            settings: const RouteSettings(arguments: {'showPostSuccess': true}),
          ),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('게시글 등록에 실패했습니다.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final postWriteState = ref.watch(postWriteProvider);
    final postWriteNotifier = ref.read(postWriteProvider.notifier);

    return Scaffold(
      appBar: const PrimaryAppBar(title: "게시글 추가", showBackButton: true),
      body: postWriteState.isLoading
          ? const AppLoadingView()
          : SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 헤더 이미지와 제목 입력
                      PostHeaderImage(
                        youtubeThumb: postWriteState.youtubeThumb,
                        backgroundImage: postWriteState.backgroundImage, // picsumUrl을 backgroundImage로 변경
                        titleController: postWriteNotifier.titleController,
                        validator: (v) => v == null || v.trim().isEmpty
                            ? '제목을 입력해 주세요.'
                            : null,
                      ),

                      // 폼 입력 필드들
                      PostFormInputs(
                        contentController: postWriteNotifier.contentController,
                        youtubeController: postWriteNotifier.youtubeController,
                        category: postWriteState.category,
                        categories: postWriteNotifier.categories,
                        onCategoryChanged: (category) =>
                            postWriteNotifier.setCategory(category ?? '자유'),
                        onSubmit: _handleSubmit,
                        isLoading: postWriteState.isLoading,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
