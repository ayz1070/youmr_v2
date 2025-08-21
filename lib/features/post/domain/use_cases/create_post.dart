import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_failure.dart';
import '../entities/post.dart';
import '../repositories/post_repository.dart';
import '../../../../core/constants/post_constants.dart';

/// 게시글 생성 UseCase
/// - 게시글 생성의 비즈니스 로직을 캡슐화
/// - 단일 책임 원칙 준수 및 도메인 규칙 검증
class CreatePost {
  /// 게시글 저장소
  final PostRepository _repository;

  /// CreatePost 생성자
  /// [repository]: 게시글 저장소 (DI)
  const CreatePost({required PostRepository repository})
      : _repository = repository;

  /// 게시글 생성 실행
  /// [authorId]: 작성자 ID
  /// [authorNickname]: 작성자 닉네임
  /// [authorProfileUrl]: 작성자 프로필 이미지 URL
  /// [title]: 제목
  /// [content]: 내용
  /// [category]: 카테고리
  /// [imageUrls]: 이미지 URL 리스트 (선택사항)
  /// [backgroundImage]: 배경 이미지 URL (선택사항)
  /// [youtubeUrl]: 유튜브 URL (선택사항)
  /// 반환: 성공 시 생성된 [Post], 실패 시 [AppFailure]
  Future<Either<AppFailure, Post>> call({
    required String authorId,
    required String authorNickname,
    String? authorProfileUrl,
    required String title,
    required String content,
    required String category,
    List<String>? imageUrls,
    String? backgroundImage,
    String? youtubeUrl,
  }) async {
    try {
      // 1. 입력값 유효성 검증
      final validationResult = _validateInputs(
        authorId: authorId,
        authorNickname: authorNickname,
        title: title,
        content: content,
        category: category,
      );

      if (validationResult.isLeft()) {
        return validationResult.fold(
          (failure) => Left(failure),
          (_) => throw Exception('유효성 검증 실패'),
        );
      }

      // 2. 게시글 엔티티 생성
      final post = Post.create(
        authorId: authorId,
        authorNickname: authorNickname,
        authorProfileUrl: authorProfileUrl,
        title: title,
        content: content,
        category: category,
        imageUrls: imageUrls,
        backgroundImage: backgroundImage,
        youtubeUrl: youtubeUrl,
      );

      // 3. 저장소를 통해 게시글 저장
      final result = await _repository.createPost(post);
      
      return result.fold(
        (failure) => Left(failure),
        (createdPost) => Right(createdPost),
      );
    } catch (e) {
      return Left(AppFailure.serverError('게시글 생성 중 오류가 발생했습니다: $e'));
    }
  }

  /// 입력값 유효성 검증
  /// [authorId]: 작성자 ID
  /// [authorNickname]: 작성자 닉네임
  /// [title]: 제목
  /// [content]: 내용
  /// [category]: 카테고리
  /// 반환: 성공 시 [void], 실패 시 [AppFailure]
  Either<AppFailure, void> _validateInputs({
    required String authorId,
    required String authorNickname,
    required String title,
    required String content,
    required String category,
  }) {
    // 작성자 ID 검증
    if (authorId.trim().isEmpty) {
      return Left(AppFailure.validationError('작성자 ID는 필수입니다.'));
    }

    // 작성자 닉네임 검증
    if (authorNickname.trim().isEmpty) {
      return Left(AppFailure.validationError('작성자 닉네임은 필수입니다.'));
    }

    // 제목 검증
    if (title.trim().isEmpty || title.length > 100) {
      return Left(AppFailure.validationError(
        '제목은 1자 이상 100자 이하여야 합니다.'
      ));
    }

    // 내용 검증
    if (content.trim().isEmpty) {
      return Left(AppFailure.validationError('게시글 내용은 필수입니다.'));
    }

    if (content.length > 10000) {
      return Left(AppFailure.validationError(
        '게시글 내용은 10,000자를 초과할 수 없습니다.'
      ));
    }

    // 카테고리 검증
    final allowedCategories = PostConstants.categories.where((c) => c != PostConstants.allCategory).toList();
    if (!allowedCategories.contains(category)) {
      return Left(AppFailure.validationError(
        '유효하지 않은 카테고리입니다: $category'
      ));
    }

    return const Right(null);
  }

  /// 게시글 생성 권한 확인
  /// [userId]: 사용자 ID
  /// [userRole]: 사용자 역할
  /// 반환: 권한 여부
  bool canCreatePost(String userId, String userRole) {
    // 기본적으로 모든 인증된 사용자는 게시글을 작성할 수 있음
    return userId.isNotEmpty;
  }

  /// 게시글 생성 제한 확인
  /// [userId]: 사용자 ID
  /// [userPostsCount]: 사용자의 게시글 수
  /// 반환: 제한 여부
  bool isPostLimitExceeded(String userId, int userPostsCount) {
    // 하루 최대 5개 게시글 작성 제한
    const int dailyPostLimit = 5;
    return userPostsCount >= dailyPostLimit;
  }
}
