import '../../domain/entities/attendance.dart';

/// 출석 DTO (Firestore <-> Domain 변환)
class AttendanceDto {
  /// 주차 키
  final String weekKey;
  
  /// 유저 고유 ID
  final String userId;
  
  /// 선택한 요일 리스트
  final List<String> selectedDays;
  
  /// 실명
  final String name;
  
  /// 프로필 이미지 URL
  final String profileImageUrl;
  
  /// 마지막 업데이트 시각
  final DateTime? lastUpdated;

  /// 생성자
  const AttendanceDto({
    required this.weekKey,
    required this.userId,
    required this.selectedDays,
    required this.name,
    required this.profileImageUrl,
    this.lastUpdated,
  });

  /// JSON에서 AttendanceDto 객체 생성
  factory AttendanceDto.fromJson(Map<String, dynamic> json) => AttendanceDto(
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

  /// 도메인 → DTO 변환
  factory AttendanceDto.fromDomain(Attendance attendance) => AttendanceDto(
    weekKey: attendance.weekKey,
    userId: attendance.userId,
    selectedDays: attendance.selectedDays,
    name: attendance.name,
    profileImageUrl: attendance.profileImageUrl,
    lastUpdated: attendance.lastUpdated,
  );
}

/// DTO → 도메인 변환 확장
extension AttendanceDtoX on AttendanceDto {
  Attendance toDomain() => Attendance(
    weekKey: weekKey,
    userId: userId,
    selectedDays: selectedDays,
    name: name,
    profileImageUrl: profileImageUrl,
    lastUpdated: lastUpdated,
  );
} 