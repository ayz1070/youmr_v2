import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/auth_user.dart';
import '../../../domain/use_cases/sign_in_with_google.dart';
import '../../../domain/use_cases/sign_out.dart';
import '../../../domain/use_cases/get_current_user.dart';
import '../../../domain/use_cases/save_profile.dart';
import '../../../domain/use_cases/upload_profile_image.dart';
import '../../../domain/use_cases/delete_profile_image.dart';
import '../../../../notification/presentation/providers/notification_provider.dart';
import '../../../di/auth_module.dart';


/// 인증 상태 관리 Notifier
/// - 인증 관련 상태 및 액션 관리
/// - UseCase들을 외부에서 의존성 주입받음
class AuthNotifier extends StateNotifier<AsyncValue<AuthUser?>> {
  /// 구글 로그인 UseCase
  final SignInWithGoogle _signInWithGoogle;
  /// 로그아웃 UseCase
  final SignOut _signOut;
  /// 현재 사용자 조회 UseCase
  final GetCurrentUser _getCurrentUser;
  /// 프로필 저장 UseCase
  final SaveProfile _saveProfile;
  /// 프로필 이미지 업로드 UseCase
  final UploadProfileImage _uploadProfileImage;
  /// 프로필 이미지 삭제 UseCase
  final DeleteProfileImage _deleteProfileImage;
  /// 알림 Provider (FCM 토큰 삭제용)
  final dynamic _notificationProvider;

  /// 생성자
  /// [signInWithGoogle] 구글 로그인 UseCase
  /// [signOut] 로그아웃 UseCase
  /// [getCurrentUser] 현재 사용자 조회 UseCase
  /// [saveProfile] 프로필 저장 UseCase
  /// [uploadProfileImage] 프로필 이미지 업로드 UseCase
  /// [deleteProfileImage] 프로필 이미지 삭제 UseCase
  /// [notificationProvider] 알림 Provider (FCM 토큰 삭제용)
  AuthNotifier({
    required SignInWithGoogle signInWithGoogle,
    required SignOut signOut,
    required GetCurrentUser getCurrentUser,
    required SaveProfile saveProfile,
    required UploadProfileImage uploadProfileImage,
    required DeleteProfileImage deleteProfileImage,
    required dynamic notificationProvider,
  }) : _signInWithGoogle = signInWithGoogle,
       _signOut = signOut,
       _getCurrentUser = getCurrentUser,
       _saveProfile = saveProfile,
       _uploadProfileImage = uploadProfileImage,
       _deleteProfileImage = deleteProfileImage,
       _notificationProvider = notificationProvider,
       super(const AsyncValue.loading());

  /// 초기화
  /// - 앱 시작 시 현재 사용자 정보 조회
  Future<void> initialize() async {
    state = const AsyncValue.loading();
    
    try {
      final result = await _getCurrentUser();
      result.fold(
        (failure) {
          // 사용자 정보 조회 실패 시 null 상태로 설정
          state = const AsyncValue.data(null);
        },
        (user) {
          // 사용자 정보가 있으면 해당 정보로, 없으면 null로 설정
          state = AsyncValue.data(user);
        },
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 구글 로그인
  /// 반환: Future<void>
  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    
    try {
      final result = await _signInWithGoogle();
      result.fold(
        (failure) {
          state = AsyncValue.error(failure, StackTrace.current);
        },
        (user) {
          state = AsyncValue.data(user);
        },
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 로그아웃
  /// 반환: Future<void>
  Future<void> signOut() async {
    state = const AsyncValue.loading();
    
    // FCM 토큰 삭제
    try {
      await _notificationProvider.deleteFcmToken();
    } catch (e) {
      // FCM 토큰 삭제 실패는 로그아웃을 막지 않음
      debugPrint('FCM 토큰 삭제 실패: $e');
    }
    
    try {
      final result = await _signOut();
      result.fold(
        (failure) {
          state = AsyncValue.error(failure, StackTrace.current);
        },
        (_) {
          // 로그아웃 성공 시 null 상태로 설정
          state = const AsyncValue.data(null);
        },
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 프로필 저장
  /// [user]: 저장할 유저 정보
  /// 반환: Future<void>
  Future<void> saveProfile(AuthUser user) async {
    state = const AsyncValue.loading();
    
    try {
      final result = await _saveProfile(user: user);
      result.fold(
        (failure) {
          state = AsyncValue.error(failure, StackTrace.current);
        },
        (_) async {
          // 저장 후 최신 정보 다시 불러오기
          final newResult = await _getCurrentUser();
          newResult.fold(
            (failure) {
              state = AsyncValue.error(failure, StackTrace.current);
            },
            (updatedUser) {
              state = AsyncValue.data(updatedUser);
            },
          );
        },
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 프로필 이미지 업로드
  /// [imageFile]: 업로드할 이미지 파일
  /// 반환: Future<String?> (성공 시 이미지 URL, 실패 시 null)
  Future<String?> uploadProfileImage(File imageFile) async {
    final currentUser = state.value;
    if (currentUser == null) return null;

    try {
      final result = await _uploadProfileImage(
        uid: currentUser.uid,
        imageFile: imageFile,
      );
      
      return result.fold(
        (failure) {
          // 에러 발생 시 현재 상태 유지
          return null;
        },
        (imageUrl) {
          // 성공 시 유저 정보 업데이트
          final updatedUser = currentUser.copyWith(profileImageUrl: imageUrl);
          state = AsyncValue.data(updatedUser);
          return imageUrl;
        },
      );
    } catch (e) {
      // 에러 발생 시 현재 상태 유지
      return null;
    }
  }

  /// 프로필 이미지 삭제
  /// 반환: Future<bool> (성공 시 true, 실패 시 false)
  Future<bool> deleteProfileImage() async {
    final currentUser = state.value;
    if (currentUser?.profileImageUrl == null) return true;

    try {
      final result = await _deleteProfileImage(
        imageUrl: currentUser!.profileImageUrl!,
      );
      
      return result.fold(
        (failure) {
          // 에러 발생 시 현재 상태 유지
          return false;
        },
        (_) {
          // 성공 시 유저 정보에서 이미지 URL 제거
          final updatedUser = currentUser.copyWith(profileImageUrl: null);
          state = AsyncValue.data(updatedUser);
          return true;
        },
      );
    } catch (e) {
      // 에러 발생 시 현재 상태 유지
      return false;
    }
  }

  /// 에러 상태 초기화
  /// - 에러 발생 후 사용자가 다시 시도할 수 있도록 상태 초기화
  void clearError() {
    final currentUser = state.value;
    if (currentUser != null) {
      state = AsyncValue.data(currentUser);
    } else {
      state = const AsyncValue.data(null);
    }
  }
} 