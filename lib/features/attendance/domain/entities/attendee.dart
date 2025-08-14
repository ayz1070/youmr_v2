/// 참석자 엔티티(불변)
/// - 출석 시스템에 참여하는 사용자의 기본 정보를 관리하는 도메인 객체
/// - 사용자 식별, 표시명, 프로필 이미지 정보를 포함
class Attendee {
  /// 사용자 고유 식별자 (Firebase Auth UID)
  final String userId;
  
  /// 사용자 표시명 (화면에 표시되는 이름)
  final String nickname;
  
  /// 사용자 프로필 이미지 URL
  final String profileImageUrl;

  /// 참석자 엔티티 생성자
  const Attendee({
    required this.userId,
    required this.nickname,
    required this.profileImageUrl,
  });

  /// JSON에서 Attendee 객체 생성
  factory Attendee.fromJson(Map<String, dynamic> json) => Attendee(
    userId: json['userId'] as String,
    nickname: json['nickname'] as String,
    profileImageUrl: json['profileImageUrl'] as String,
  );

  /// JSON으로 변환
  Map<String, dynamic> toJson() => {
    'userId': userId,
    'nickname': nickname,
    'profileImageUrl': profileImageUrl,
  };

  /// 사용자 ID 유효성 검사
  /// - Firebase Auth UID 형식: 28자 영숫자 문자열
  /// - 빈 문자열은 허용하지 않음
  static bool isValidUserId(String userId) {
    if (userId.isEmpty) return false;
    
    // Firebase Auth UID는 보통 28자 영숫자로 구성
    final regex = RegExp(r'^[a-zA-Z0-9]{28}$');
    return regex.hasMatch(userId);
  }

  /// 닉네임 유효성 검사
  /// - 길이: 1-20자
  /// - 빈 문자열이나 공백만으로 구성된 닉네임은 허용하지 않음
  /// - 특수문자 제한: 영문, 한글, 숫자, 공백, 하이픈(-), 언더스코어(_)만 허용
  static bool isValidNickname(String nickname) {
    final trimmedNickname = nickname.trim();
    if (trimmedNickname.isEmpty || trimmedNickname.length > 20) {
      return false;
    }
    
    // 영문, 한글, 숫자, 공백, 하이픈, 언더스코어만 허용
    final regex = RegExp(r'^[a-zA-Z0-9가-힣\s\-_]+$');
    return regex.hasMatch(trimmedNickname);
  }

  /// 프로필 이미지 URL 유효성 검사
  /// - HTTP/HTTPS 프로토콜 사용
  /// - 이미지 파일 확장자 (.jpg, .jpeg, .png, .gif, .webp)
  /// - 기본 프로필 이미지 URL도 허용 (default_profile.png 등)
  static bool isValidProfileImageUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    
    final scheme = uri.scheme.toLowerCase();
    if (scheme != 'http' && scheme != 'https') return false;
    
    final path = uri.path.toLowerCase();
    final validExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp'];
    
    // 기본 프로필 이미지도 허용
    if (path.contains('default_profile') || path.contains('default-')) {
      return true;
    }
    
    return validExtensions.any((ext) => path.endsWith(ext));
  }

  /// 현재 객체의 유효성 검사
  /// - 모든 필수 필드의 유효성을 검사하여 도메인 규칙 준수 여부 확인
  bool get isValid {
    return isValidUserId(userId) &&
           isValidNickname(nickname) &&
           isValidProfileImageUrl(profileImageUrl);
  }

  /// 닉네임 길이 반환
  int get nicknameLength => nickname.length;

  /// 닉네임이 기본값인지 확인
  /// - 기본값: "사용자", "User", "Anonymous" 등
  bool get isDefaultNickname {
    const defaultNicknames = [
      '사용자', 'User', 'Anonymous', 'Anonymous User', 'Unknown'
    ];
    return defaultNicknames.contains(nickname.trim());
  }

  /// 프로필 이미지가 기본 이미지인지 확인
  /// - 기본 이미지: default_profile.png, default- 등 포함
  bool get isDefaultProfileImage {
    return profileImageUrl.contains('default_profile') ||
           profileImageUrl.contains('default-') ||
           profileImageUrl.contains('default_');
  }

  /// 프로필 이미지가 네트워크 이미지인지 확인
  /// - HTTP/HTTPS URL인지 확인
  bool get isNetworkImage {
    final uri = Uri.tryParse(profileImageUrl);
    if (uri == null) return false;
    
    final scheme = uri.scheme.toLowerCase();
    return scheme == 'http' || scheme == 'https';
  }

  /// 프로필 이미지가 로컬 에셋인지 확인
  /// - assets/ 경로를 포함하는지 확인
  bool get isLocalAsset {
    return profileImageUrl.startsWith('assets/');
  }

  /// 사용자 ID가 유효한지 확인
  bool get hasValidUserId => isValidUserId(userId);

  /// 닉네임이 유효한지 확인
  bool get hasValidNickname => isValidNickname(nickname);

  /// 프로필 이미지 URL이 유효한지 확인
  bool get hasValidProfileImageUrl => isValidProfileImageUrl(profileImageUrl);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Attendee &&
           other.userId == userId &&
           other.nickname == nickname &&
           other.profileImageUrl == profileImageUrl;
  }

  @override
  int get hashCode {
    return Object.hash(userId, nickname, profileImageUrl);
  }

  @override
  String toString() {
    return 'Attendee(userId: $userId, nickname: $nickname, profileImageUrl: $profileImageUrl)';
  }
}