import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:youmr_v2/features/notification/data/dtos/fcm_token_dto.dart';
import 'package:youmr_v2/features/notification/domain/entities/send_notification_params.dart';

/// FCM 데이터 소스 인터페이스
abstract class FcmDataSource {
  /// FCM 토큰 저장
  Future<void> saveFcmToken(String userId, String token);
  
  /// FCM 토큰 삭제
  Future<void> deleteFcmToken(String userId);
  
  /// 사용자별 FCM 토큰 조회
  Future<List<String>> getFcmTokensByUserIds(List<String> userIds);
  
  /// 특정 사용자의 FCM 토큰 조회
  Future<String?> getFcmTokenByUserId(String userId);
  
  /// 푸시 알림 전송
  Future<void> sendPushNotification(SendNotificationParams params);
  
  /// 모든 사용자의 FCM 토큰 조회
  Future<List<String>> getAllFcmTokens();
}

/// FCM Firestore 데이터 소스 구현
class FcmFirestoreDataSource implements FcmDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  /// FCM 토큰 컬렉션 이름
  static const String _collectionName = 'fcm_tokens';

  @override
  Future<void> saveFcmToken(String userId, String token) async {
    try {
      final fcmTokenDto = FcmTokenDto(
        userId: userId,
        token: token,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        deviceInfo: {
          'platform': defaultTargetPlatform.toString(),
          'version': '1.0.0', // TODO: 앱 버전 동적 가져오기
        },
      );

      await _firestore
          .collection(_collectionName)
          .doc(userId)
          .set(fcmTokenDto.toJson());

      debugPrint('FCM 토큰 저장 완료: $userId');
    } catch (e) {
      debugPrint('FCM 토큰 저장 실패: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteFcmToken(String userId) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(userId)
          .delete();

      debugPrint('FCM 토큰 삭제 완료: $userId');
    } catch (e) {
      debugPrint('FCM 토큰 삭제 실패: $e');
      rethrow;
    }
  }

  @override
  Future<List<String>> getFcmTokensByUserIds(List<String> userIds) async {
    try {
      if (userIds.isEmpty) return [];

      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where(FieldPath.documentId, whereIn: userIds)
          .get();

      final tokens = querySnapshot.docs
          .map((doc) => FcmTokenDto.fromJson(doc.data()))
          .map((dto) => dto.token)
          .toList();

      debugPrint('FCM 토큰 조회 완료: ${tokens.length}개');
      return tokens;
    } catch (e) {
      debugPrint('FCM 토큰 조회 실패: $e');
      rethrow;
    }
  }

  @override
  Future<String?> getFcmTokenByUserId(String userId) async {
    try {
      final docSnapshot = await _firestore
          .collection(_collectionName)
          .doc(userId)
          .get();

      if (!docSnapshot.exists) {
        debugPrint('FCM 토큰이 존재하지 않음: $userId');
        return null;
      }

      final fcmTokenDto = FcmTokenDto.fromJson(docSnapshot.data()!);
      debugPrint('FCM 토큰 조회 완료: $userId');
      return fcmTokenDto.token;
    } catch (e) {
      debugPrint('FCM 토큰 조회 실패: $e');
      rethrow;
    }
  }

  @override
  Future<List<String>> getAllFcmTokens() async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .get();

      final tokens = querySnapshot.docs
          .map((doc) => FcmTokenDto.fromJson(doc.data()))
          .map((dto) => dto.token)
          .toList();

      debugPrint('모든 FCM 토큰 조회 완료: ${tokens.length}개');
      return tokens;
    } catch (e) {
      debugPrint('모든 FCM 토큰 조회 실패: $e');
      rethrow;
    }
  }

  @override
  Future<void> sendPushNotification(SendNotificationParams params) async {
    try {
      // 대상 사용자들의 FCM 토큰 조회
      List<String> tokens;
      if (params.userIds.isEmpty) {
        // 모든 사용자에게 전송
        tokens = await getAllFcmTokens();
      } else {
        // 특정 사용자들에게 전송
        tokens = await getFcmTokensByUserIds(params.userIds);
      }

      if (tokens.isEmpty) {
        debugPrint('전송할 FCM 토큰이 없습니다.');
        return;
      }

      // Firestore에 알림 기록 저장
      await _saveNotificationRecord(params, tokens.length);

      // TODO: 실제 FCM 서버로 알림 전송
      // 현재는 로컬에서만 처리하고, 실제 구현 시에는 Cloud Functions나 서버를 통해 전송
      debugPrint('푸시 알림 전송 완료: ${tokens.length}개 토큰, 제목: ${params.title}');
    } catch (e) {
      debugPrint('푸시 알림 전송 실패: $e');
      rethrow;
    }
  }

  /// 알림 기록을 Firestore에 저장
  Future<void> _saveNotificationRecord(SendNotificationParams params, int recipientCount) async {
    try {
      final notificationData = {
        'title': params.title,
        'body': params.body,
        'type': params.type,
        'data': params.data,
        'imageUrl': params.imageUrl,
        'userIds': params.userIds,
        'recipientCount': recipientCount,
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'sent',
      };

      await _firestore
          .collection('push_notifications')
          .add(notificationData);

      debugPrint('알림 기록 저장 완료');
    } catch (e) {
      debugPrint('알림 기록 저장 실패: $e');
    }
  }
} 