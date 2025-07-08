/// 회원 타입 값 객체 (enum + 확장자)
enum UserType {
  admin,
  developer,
  offlineMember,
  member,
}

extension UserTypeX on UserType {
  String get displayName {
    switch (this) {
      case UserType.admin:
        return '관리자';
      case UserType.developer:
        return '개발자';
      case UserType.offlineMember:
        return '오프라인 회원';
      case UserType.member:
        return '일반 회원';
    }
  }

  String get firestoreValue {
    switch (this) {
      case UserType.admin:
        return 'admin';
      case UserType.developer:
        return 'developer';
      case UserType.offlineMember:
        return 'offline_member';
      case UserType.member:
        return 'member';
    }
  }

  static UserType fromFirestore(String value) {
    switch (value) {
      case 'admin':
        return UserType.admin;
      case 'developer':
        return UserType.developer;
      case 'offline_member':
        return UserType.offlineMember;
      case 'member':
      default:
        return UserType.member;
    }
  }
} 