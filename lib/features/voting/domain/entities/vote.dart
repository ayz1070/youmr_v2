import 'package:freezed_annotation/freezed_annotation.dart';

part 'vote.freezed.dart';
part 'vote.g.dart';

/// 투표 곡 도메인 모델
@freezed
class Vote with _$Vote {
  const factory Vote({
    required String id,
    required String title,
    required String artist,
    String? youtubeUrl,
    required int voteCount,
    required DateTime createdAt,
    required String createdBy,
  }) = _Vote;

  factory Vote.fromJson(Map<String, dynamic> json) => _$VoteFromJson(json);
} 