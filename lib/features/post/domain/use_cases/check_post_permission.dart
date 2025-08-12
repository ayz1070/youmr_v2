import 'package:firebase_auth/firebase_auth.dart';

/// 게시글 수정/삭제 권한 확인 use case
/// - 사용자가 게시글을 수정/삭제할 수 있는 권한이 있는지 확인하는 비즈니스 로직
class CheckPostPermission {
  /// 게시글 수정/삭제 권한 확인 실행
  /// [postAuthorId]: 게시글 작성자 ID
  /// 반환: 권한 여부
  Future<bool> call(String postAuthorId) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) return false;

      // 본인이 작성한 게시글인지 확인
      if (postAuthorId == currentUser.uid) return true;

      // 관리자 권한 확인 (임시로 displayName 사용)
      final userType = currentUser.displayName;
      if (userType == 'admin' || userType == 'developer') return true;

      return false;
    } catch (e) {
      return false;
    }
  }
}
