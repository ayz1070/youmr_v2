import '../repositories/auth_repository.dart';
import '../../core/errors/auth_failure.dart';
import 'package:dartz/dartz.dart';

/// 프로필 이미지 삭제 유즈케이스
/// - 유저의 프로필 이미지를 Firebase Storage에서 삭제
class DeleteProfileImage {
  /// 인증 레포지토리
  final AuthRepository repository;

  /// [repository]: 인증 레포지토리 DI
  const DeleteProfileImage(this.repository);

  /// 프로필 이미지 삭제 실행
  /// [imageUrl]: 삭제할 이미지 URL
  /// 반환: 성공 시 void, 실패 시 [AuthFailure]
  Future<Either<AuthFailure, void>> call({required String imageUrl}) {
    return repository.deleteProfileImage(imageUrl: imageUrl);
  }
} 