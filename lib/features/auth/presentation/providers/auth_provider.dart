import 'dart:async';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/use_cases/sign_in_with_google.dart';
import '../../domain/use_cases/sign_out.dart';
import '../../domain/use_cases/get_current_user.dart';
import '../../domain/use_cases/save_profile.dart';
import '../../domain/use_cases/upload_profile_image.dart';
import '../../domain/use_cases/delete_profile_image.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/data_sources/auth_firebase_data_source.dart';

/// 인증 상태 관리 Provider (AsyncNotifier)
/// - 실제 앱에서는 ProviderScope override로 DI/Mock 주입 구조 권장
final authProvider = AsyncNotifierProvider<AuthNotifier, AuthUser?>(
  AuthNotifier.new,
);

/// 인증 상태 관리 Notifier
/// - 인증 관련 상태 및 액션 관리
class AuthNotifier extends AsyncNotifier<AuthUser?> {
  late final SignInWithGoogle _signInWithGoogle;
  late final SignOut _signOut;
  late final GetCurrentUser _getCurrentUser;
  late final SaveProfile _saveProfile;
  late final UploadProfileImage _uploadProfileImage;
  late final DeleteProfileImage _deleteProfileImage;

  @override
  FutureOr<AuthUser?> build() async {
    // DI: 실제 구현체 주입 (실제 앱에서는 외부에서 주입 권장)
    final repository = AuthRepositoryImpl(
      dataSource: AuthFirebaseDataSource(),
      googleSignIn: GoogleSignIn(),
    );
    _signInWithGoogle = SignInWithGoogle(repository);
    _signOut = SignOut(repository);
    _getCurrentUser = GetCurrentUser(repository);
    _saveProfile = SaveProfile(repository);
    _uploadProfileImage = UploadProfileImage(repository);
    _deleteProfileImage = DeleteProfileImage(repository);

    // 현재 로그인 유저 정보 불러오기
    final result = await _getCurrentUser();
    return result.fold(
      (failure) => throw AsyncError(failure, StackTrace.current),
      (user) => user,
    );
  }

  /// 구글 로그인
  /// 반환: Future<void>
  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    final result = await _signInWithGoogle();
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (user) => state = AsyncValue.data(user),
    );
  }

  /// 로그아웃
  /// 반환: Future<void>
  Future<void> signOut() async {
    state = const AsyncValue.loading();
    final result = await _signOut();
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) => state = const AsyncValue.data(null),
    );
  }

  /// 프로필 저장
  /// [user]: 저장할 유저 정보
  /// 반환: Future<void>
  Future<void> saveProfile(AuthUser user) async {
    state = const AsyncValue.loading();
    final result = await _saveProfile(user: user);
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) async {
        // 저장 후 최신 정보 다시 불러오기
        final newResult = await _getCurrentUser();
        newResult.fold(
          (failure) => state = AsyncValue.error(failure, StackTrace.current),
          (user) => state = AsyncValue.data(user),
        );
      },
    );
  }

  /// 프로필 이미지 업로드
  /// [imageFile]: 업로드할 이미지 파일
  /// 반환: Future<String?> (성공 시 이미지 URL, 실패 시 null)
  Future<String?> uploadProfileImage(File imageFile) async {
    final currentUser = state.value;
    if (currentUser == null) return null;

    final result = await _uploadProfileImage(uid: currentUser.uid, imageFile: imageFile);
    return result.fold(
      (failure) {
        // 에러 발생 시 스낵바 표시
        return null;
      },
      (imageUrl) {
        // 성공 시 유저 정보 업데이트
        final updatedUser = currentUser.copyWith(profileImageUrl: imageUrl);
        state = AsyncValue.data(updatedUser);
        return imageUrl;
      },
    );
  }

  /// 프로필 이미지 삭제
  /// 반환: Future<bool> (성공 시 true, 실패 시 false)
  Future<bool> deleteProfileImage() async {
    final currentUser = state.value;
    if (currentUser?.profileImageUrl == null) return true;

    final result = await _deleteProfileImage(imageUrl: currentUser!.profileImageUrl!);
    return result.fold(
      (failure) {
        // 에러 발생 시 스낵바 표시
        return false;
      },
      (_) {
        // 성공 시 유저 정보에서 이미지 URL 제거
        final updatedUser = currentUser.copyWith(profileImageUrl: null);
        state = AsyncValue.data(updatedUser);
        return true;
      },
    );
  }
} 