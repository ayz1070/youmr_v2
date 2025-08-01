import 'dart:io';
import '../repositories/auth_repository.dart';
import '../../core/errors/auth_failure.dart';
import 'package:dartz/dartz.dart';

/// 프로필 이미지 업로드 유즈케이스
/// - 유저의 프로필 이미지를 Firebase Storage에 업로드
class UploadProfileImage {
  /// 인증 레포지토리
  final AuthRepository repository;

  /// [repository]: 인증 레포지토리 DI
  const UploadProfileImage(this.repository);

  /// 프로필 이미지 업로드 실행
  /// [uid]: 유저 고유 ID
  /// [imageFile]: 업로드할 이미지 파일
  /// 반환: 성공 시 이미지 URL, 실패 시 [AuthFailure]
  Future<Either<AuthFailure, String>> call({
    required String uid,
    required File imageFile,
  }) {
    return repository.uploadProfileImage(uid: uid, imageFile: imageFile);
  }
} 