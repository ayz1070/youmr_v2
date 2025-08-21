/// 프로필 설정 관련 상수
class ProfileSetupConstants {
  /// 요일 리스트
  static const List<String> days = ['월', '화', '수', '목', '금', '토', '일'];

  /// 회원 타입
  static const String offlineMember = 'offline_member';
  static const String member = 'member';

  /// 에러 메시지
  static const String nicknameRequired = '닉네임을 입력하세요';
  static const String userTypeRequired = '회원 타입을 선택해 주세요.';
  static const String dayOfWeekRequired = '요일을 선택해 주세요.';
  static const String loginInfoNotFound = '로그인 정보가 없습니다.';
  static const String imageUploadFailed = '프로필 이미지 업로드에 실패했습니다.';
  static const String imageUploadError = '프로필 이미지 업로드 실패: ';
  static const String profileSaveFailed = '프로필 저장 실패: ';
  static const String imageSelectionFailed = '이미지 선택 실패: ';

  /// 성공 메시지
  static const String imageUploadSuccess = '프로필 이미지가 업로드되었습니다.';

  /// UI 텍스트
  static const String pageTitle = '프로필 설정';
  static const String nicknameLabel = '닉네임';
  static const String nicknameHint = '닉네임을 입력하세요';
  static const String userTypeLabel = '회원 유형';
  static const String userTypeHint = '여민락 회원은 오프라인 회원 선택';
  static const String offlineMemberText = '오프라인 회원';
  static const String onlineMemberText = '온라인 회원';
  static const String dayOfWeekLabel = '요일 선택';
  static const String dayOfWeekHint = '참여하는 요일을 선택하세요';
  static const String confirmButton = '확인';
  static const String imagePickerTitle = '프로필 이미지 선택';
  static const String cameraOption = '카메라로 촬영';
  static const String galleryOption = '갤러리에서 선택';
  static const String selectedImageText = '선택된 이미지';
  static const String currentImageText = '현재 프로필 이미지';
  static const String defaultImageText = '기본 프로필 이미지';
} 