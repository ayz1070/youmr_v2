/// 게시글 작성 페이지의 상태
class PostWriteState {
  final String category;
  final bool isLoading;
  final String? youtubeThumb;
  final String backgroundImage; // picsumUrl을 backgroundImage로 변경
  final List<String> imageUrls; // 이미지 URL 리스트
  final String? error;

  const PostWriteState({
    required this.category,
    required this.isLoading,
    required this.youtubeThumb,
    required this.backgroundImage,
    this.imageUrls = const [],
    this.error,
  });

  PostWriteState copyWith({
    String? category,
    bool? isLoading,
    String? youtubeThumb,
    String? backgroundImage,
    List<String>? imageUrls,
    String? error,
  }) {
    return PostWriteState(
      category: category ?? this.category,
      isLoading: isLoading ?? this.isLoading,
      youtubeThumb: youtubeThumb ?? this.youtubeThumb,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      imageUrls: imageUrls ?? this.imageUrls,
      error: error ?? this.error,
    );
  }
}