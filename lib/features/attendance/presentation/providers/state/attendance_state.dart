import '../../../domain/entities/attendance.dart';

/// 출석 상태를 관리하는 sealed class
sealed class AttendanceState {
  const AttendanceState();
  
  /// 초기 상태
  static const AttendanceState initial = _Initial();
  
  /// 로딩 상태
  static const AttendanceState loading = _Loading();
  
  /// 성공 상태 (출석 데이터 포함)
  static AttendanceState success({required Attendance attendance}) => _Success(attendance: attendance);
  
  /// 에러 상태
  static AttendanceState error({required String message, String? errorDetail}) => _Error(message: message, errorDetail: errorDetail);
  
  /// 빈 상태 (출석 데이터가 없는 경우)
  static const AttendanceState empty = _Empty();
}

/// 초기 상태 구현
class _Initial extends AttendanceState {
  const _Initial();
}

/// 로딩 상태 구현
class _Loading extends AttendanceState {
  const _Loading();
}

/// 성공 상태 구현
class _Success extends AttendanceState {
  final Attendance attendance;
  
  const _Success({required this.attendance});
}

/// 에러 상태 구현
class _Error extends AttendanceState {
  final String message;
  final String? errorDetail;
  
  const _Error({required this.message, this.errorDetail});
}

/// 빈 상태 구현
class _Empty extends AttendanceState {
  const _Empty();
}

/// 출석 상태 확장 메서드
extension AttendanceStateX on AttendanceState {
  /// 현재 출석 데이터 반환
  Attendance? get attendance => switch (this) {
    _Initial() => null,
    _Loading() => null,
    _Success(attendance: final attendance) => attendance,
    _Error() => null,
    _Empty() => null,
  };
  
  /// 로딩 중인지 확인
  bool get isLoading => switch (this) {
    _Initial() => false,
    _Loading() => true,
    _Success() => false,
    _Error() => false,
    _Empty() => false,
  };
  
  /// 에러가 발생했는지 확인
  bool get hasError => switch (this) {
    _Initial() => false,
    _Loading() => false,
    _Success() => false,
    _Error() => true,
    _Empty() => false,
  };
  
  /// 데이터가 있는지 확인
  bool get hasData => switch (this) {
    _Initial() => false,
    _Loading() => false,
    _Success() => true,
    _Error() => false,
    _Empty() => false,
  };
}
