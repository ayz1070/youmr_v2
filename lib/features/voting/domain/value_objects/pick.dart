/// 피크(투표권) 값 객체
class Pick {
  final int value;

  Pick(this.value) : assert(value >= 0, '피크는 0 이상이어야 합니다.');
} 