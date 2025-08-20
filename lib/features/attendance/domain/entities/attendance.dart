/// 출석 엔티티(불변)
/// - 사용자의 주간 출석 정보를 관리하는 도메인 객체
/// - weekKey를 기준으로 한 주의 출석 데이터를 저장
class Attendance {
  final String weekKey;
  
  /// 사용자 고유 식별자
  final String userId;
  
  /// 선택된 요일 목록 (예: ["월", "화", "수"])
  final List<String> selectedDays;
  
  /// 사용자 이름
  final String name;
  
  /// 사용자 프로필 이미지 URL
  final String profileImageUrl;
  
  /// 마지막 업데이트 시간 (선택사항)
  final DateTime? lastUpdated;

  /// 출석 엔티티 생성자
  const Attendance({
    required this.weekKey,
    required this.userId,
    required this.selectedDays,
    required this.name,
    required this.profileImageUrl,
    this.lastUpdated,
  });

  /// JSON에서 Attendance 객체 생성
  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    weekKey: json['weekKey'] as String,
    userId: json['userId'] as String,
    selectedDays: List<String>.from(json['selectedDays'] as List),
    name: json['name'] as String,
    profileImageUrl: json['profileImageUrl'] as String,
    lastUpdated: json['lastUpdated'] != null 
        ? DateTime.parse(json['lastUpdated'] as String) 
        : null,
  );

  /// JSON으로 변환
  Map<String, dynamic> toJson() => {
    'weekKey': weekKey,
    'userId': userId,
    'selectedDays': selectedDays,
    'name': name,
    'profileImageUrl': profileImageUrl,
    'lastUpdated': lastUpdated?.toIso8601String(),
  };

  /// 객체 복사 (특정 필드만 변경)
  Attendance copyWith({
    String? weekKey,
    String? userId,
    List<String>? selectedDays,
    String? name,
    String? profileImageUrl,
    DateTime? lastUpdated,
  }) {
    return Attendance(
      weekKey: weekKey ?? this.weekKey,
      userId: userId ?? this.userId,
      selectedDays: selectedDays ?? this.selectedDays,
      name: name ?? this.name,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }


  /// 선택된 요일 목록 유효성 검사
  /// - 유효한 요일: ["월", "화", "수", "목", "금", "토", "일"]
  /// - 최대 7일까지 선택 가능
  /// - 중복된 요일은 허용하지 않음
  static bool isValidSelectedDays(List<String> selectedDays) {
    const validDays = ['월', '화', '수', '목', '금', '토', '일'];
    const maxDays = 7;
    
    if (selectedDays.length > maxDays) return false;
    
    final uniqueDays = selectedDays.toSet();
    if (uniqueDays.length != selectedDays.length) return false;
    
    return selectedDays.every((day) => validDays.contains(day));
  }

  /// 사용자 이름 유효성 검사
  /// - 길이: 1-20자
  /// - 빈 문자열이나 공백만으로 구성된 이름은 허용하지 않음
  static bool isValidName(String name) {
    final trimmedName = name.trim();
    return trimmedName.isNotEmpty && trimmedName.length <= 20;
  }

  /// 프로필 이미지 URL 유효성 검사
  /// - HTTP/HTTPS 프로토콜 사용
  /// - 이미지 파일 확장자 (.jpg, .jpeg, .png, .gif, .webp)
  static bool isValidProfileImageUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    
    final scheme = uri.scheme.toLowerCase();
    if (scheme != 'http' && scheme != 'https') return false;
    
    final path = uri.path.toLowerCase();
    final validExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp'];
    return validExtensions.any((ext) => path.endsWith(ext));
  }

  /// 현재 객체의 유효성 검사
  /// - 모든 필수 필드의 유효성을 검사하여 도메인 규칙 준수 여부 확인
  bool get isValid {
    return userId.isNotEmpty &&
           isValidSelectedDays(selectedDays) &&
           isValidName(name) &&
           isValidProfileImageUrl(profileImageUrl);
  }

  /// 선택된 요일 수 반환
  int get selectedDaysCount => selectedDays.length;

  /// 특정 요일이 선택되었는지 확인
  /// [day] 확인할 요일 (예: "월", "화")
  bool isDaySelected(String day) => selectedDays.contains(day);

  /// 새로운 요일 추가
  /// [day] 추가할 요일
  /// 반환: 새로운 Attendance 객체 (기존 객체는 변경되지 않음)
  Attendance addDay(String day) {
    if (selectedDays.contains(day)) return this;
    final newDays = List<String>.from(selectedDays)..add(day);
    return copyWith(selectedDays: newDays);
  }

  /// 요일 제거
  /// [day] 제거할 요일
  /// 반환: 새로운 Attendance 객체 (기존 객체는 변경되지 않음)
  Attendance removeDay(String day) {
    if (!selectedDays.contains(day)) return this;
    final newDays = List<String>.from(selectedDays)..remove(day);
    return copyWith(selectedDays: newDays);
  }

  /// 요일 토글 (있으면 제거, 없으면 추가)
  /// [day] 토글할 요일
  /// 반환: 새로운 Attendance 객체 (기존 객체는 변경되지 않음)
  Attendance toggleDay(String day) {
    return selectedDays.contains(day) ? removeDay(day) : addDay(day);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Attendance &&
           other.weekKey == weekKey &&
           other.userId == userId &&
           other.selectedDays.length == selectedDays.length &&
           other.selectedDays.every((day) => selectedDays.contains(day)) &&
           other.name == name &&
           other.profileImageUrl == profileImageUrl;
  }

  @override
  int get hashCode {
    return Object.hash(
      weekKey,
      userId,
      Object.hashAll(selectedDays),
      name,
      profileImageUrl,
    );
  }

  @override
  String toString() {
    return 'Attendance(weekKey: $weekKey, userId: $userId, selectedDays: $selectedDays, name: $name, profileImageUrl: $profileImageUrl, lastUpdated: $lastUpdated)';
  }
}