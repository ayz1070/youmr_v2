/// 게시글 관련 상수들을 정의하는 클래스
class PostConstants {
  /// 게시글 카테고리 목록
  static const List<String> categories = ['전체', '자유', '멤버모집', '영상'];
  
  /// 기본 카테고리 (글쓰기 시 기본값)
  static const String defaultCategory = '자유';
  
  /// 전체 카테고리 (모든 게시글 조회용)
  static const String allCategory = '전체';
  
  /// 카테고리별 표시명 (필요시 확장 가능)
  static const Map<String, String> categoryDisplayNames = {
    '전체': '전체',
    '자유': '자유',
    '멤버모집': '멤버모집',
    '영상': '영상',
  };
  
  /// 카테고리별 아이콘 (필요시 확장 가능)
  static const Map<String, String> categoryIcons = {
    '전체': 'all_inclusive',
    '자유': 'chat',
    '멤버모집': 'music_note',
    '영상': 'video_library',
  };
}
