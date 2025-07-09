import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/vote.dart';

part 'vote_dto.freezed.dart';
part 'vote_dto.g.dart';

/// Firestore 투표 곡 문서 매핑용 DTO
@freezed
class VoteDto with _$VoteDto {
  const factory VoteDto({
    required String id,
    required String title,
    required String artist,
    String? youtubeUrl,
    required int voteCount,
    @TimestampOrDateTimeConverter() required DateTime createdAt,
    required String createdBy,
  }) = _VoteDto;

  factory VoteDto.fromJson(Map<String, dynamic> json) => _$VoteDtoFromJson(json);
}

/// Firestore Timestamp 또는 String을 모두 지원하는 DateTime 컨버터
class TimestampOrDateTimeConverter implements JsonConverter<DateTime, Object> {
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


extension VoteDtoX on VoteDto {
  Vote toDomain() => Vote(
    id: id,
    title: title,
    artist: artist,
    youtubeUrl: youtubeUrl,
    voteCount: voteCount,
    createdAt: createdAt,
    createdBy: createdBy,
  );
} 