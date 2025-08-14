import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/vote.dart';

part 'vote_dto.freezed.dart';
part 'vote_dto.g.dart';

/// Firestore 투표 곡 문서 매핑용 DTO
@freezed
class VoteDto with _$VoteDto {
  /// 생성자
  const factory VoteDto({
    /// 곡 문서 ID
    required String id,
    /// 곡 제목
    required String title,
    /// 아티스트
    required String artist,
    /// 유튜브 URL
    String? youtubeUrl,
    /// 득표수
    required int voteCount,
    /// 생성일
    @TimestampOrDateTimeConverter() required DateTime createdAt,
    /// 등록자 ID
    required String createdBy,
    /// 작성자 닉네임
    String? authorNickname,
    /// 작성자 프로필 이미지 URL
    String? authorProfileUrl,
  }) = _VoteDto;

  /// JSON → DTO 변환
  factory VoteDto.fromJson(Map<String, dynamic> json) =>
      _$VoteDtoFromJson(json);

  /// 도메인 → DTO 변환
  factory VoteDto.fromDomain(Vote vote) => VoteDto(
        id: vote.id,
        title: vote.title,
        artist: vote.artist,
        youtubeUrl: vote.youtubeUrl,
        voteCount: vote.voteCount,
        createdAt: vote.createdAt,
        createdBy: vote.createdBy,
        authorNickname: vote.authorNickname,
        authorProfileUrl: vote.authorProfileUrl,
      );

  /// 새 투표 생성용 DTO (ID 없음, 생성일은 현재 시간)
  factory VoteDto.save({
    required String title,
    required String artist,
    String? youtubeUrl,
    required String createdBy,
    String? authorNickname,
    String? authorProfileUrl,
  }) => VoteDto(
        id: '', // Firestore에서 자동 생성
        title: title,
        artist: artist,
        youtubeUrl: youtubeUrl,
        voteCount: 0, // 초기 득표수
        createdAt: DateTime.now(),
        createdBy: createdBy,
        authorNickname: authorNickname,
        authorProfileUrl: authorProfileUrl,
      );
}

/// Firestore Timestamp 또는 String을 모두 지원하는 DateTime 컨버터
class TimestampOrDateTimeConverter
    implements JsonConverter<DateTime, Object> {
  const TimestampOrDateTimeConverter();

  @override
  DateTime fromJson(Object json) {
    if (json is Timestamp) {
      return json.toDate();
    } else if (json is String) {
      return DateTime.parse(json);
    } else {
      throw Exception('지원하지 않는 날짜 형식입니다: $json');
    }
  }

  @override
  Object toJson(DateTime object) => object.toIso8601String();
}

/// VoteDto → 도메인 모델 변환 확장
extension VoteDtoX on VoteDto {
  /// VoteDto → Vote 변환
  Vote toDomain() => Vote(
        id: id,
        title: title,
        artist: artist,
        youtubeUrl: youtubeUrl,
        voteCount: voteCount,
        createdAt: createdAt,
        createdBy: createdBy,
        authorNickname: authorNickname,
        authorProfileUrl: authorProfileUrl,
      );
} 