/// Firestore 컬렉션 및 필드명 상수
class FirestoreConstants {
  static const String attendancesCollection = 'attendances';
  static const String usersCollection = 'users';
  static const String weekKey = 'weekKey';
  static const String userId = 'userId';
  static const String selectedDays = 'selectedDays';
  static const String nickname = 'nickname';
  static const String profileImageUrl = 'profileImageUrl';
  static const String lastUpdated = 'lastUpdated';
  static const String userType = 'userType';
  static const String createdAt = 'createdAt';

  /// 투표 곡 컬렉션명
  static const String votesCollection = 'votes';
  /// 사용자 투표 기록 컬렉션명
  static const String userVotesCollection = 'userVotes';
  /// 곡 제목 필드명
  static const String voteTitle = 'title';
  /// 곡 아티스트 필드명
  static const String voteArtist = 'artist';
  /// 곡 유튜브 URL 필드명
  static const String voteYoutubeUrl = 'youtubeUrl';
  /// 곡 득표수 필드명
  static const String voteCount = 'voteCount';
  /// 곡 생성일 필드명
  static const String voteCreatedAt = 'createdAt';
  /// 곡 등록자 필드명
  static const String voteCreatedBy = 'createdBy';
  /// 피크 필드명
  static const String pick = 'pick';
  /// 마지막 피크 획득일 필드명
  static const String lastPickDate = 'lastPickDate';
}