import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';
import '../constants/app_logger.dart';

/// 환경변수 설정을 관리하는 클래스
class EnvConfig {
  static const String _envFileName = '.env';
  
  /// 환경변수 초기화
  static Future<void> initialize() async {
    try {
      await dotenv.load(fileName: _envFileName);
      AppLogger.i('환경변수 로드 완료');
    } catch (e) {
      AppLogger.e('환경변수 로드 실패: $e');
      // 환경변수 로드 실패 시 기본값 사용
    }
  }

  /// AdMob Application ID 반환 (환경에 따라)
  static String get admobApplicationId {
    if (kDebugMode) {
      /// TODO 개발 서버 완료 시 개발서버로 교체
      final devId = dotenv.env['ADMOB_APPLICATION_ID_DEV'];
      if (devId == null) {
        throw StateError('ADMOB_APPLICATION_ID_DEV not set in .env file');
      }
      return devId;
    } else {
      final prodId = dotenv.env['ADMOB_APPLICATION_ID_PROD'];
      if (prodId == null) {
        throw StateError('ADMOB_APPLICATION_ID_PROD not set in .env file');
      }
      return prodId;
    }
  }

  /// AdMob 배너 광고 ID 반환 (환경에 따라)
  static String get admobBannerAdUnitId {
    if (kDebugMode) {
      final devId = dotenv.env['ADMOB_BANNER_AD_UNIT_ID_DEV'];
      if (devId == null) {
        throw StateError('ADMOB_BANNER_AD_UNIT_ID_DEV not set in .env file');
      }
      return devId;
    } else {
      final prodId = dotenv.env['ADMOB_BANNER_AD_UNIT_ID_PROD'];
      if (prodId == null) {
        throw StateError('ADMOB_BANNER_AD_UNIT_ID_PROD not set in .env file');
      }
      return prodId;
    }
  }

  /// AdMob 전면 광고 ID 반환 (환경에 따라)
  static String get admobInterstitialAdUnitId {
    if (kDebugMode) {
      final devId = dotenv.env['ADMOB_INTERSTITIAL_AD_UNIT_ID_DEV'];
      if (devId == null) {
        throw StateError('ADMOB_INTERSTITIAL_AD_UNIT_ID_DEV not set in .env file');
      }
      return devId;
    } else {
      final prodId = dotenv.env['ADMOB_INTERSTITIAL_AD_UNIT_ID_PROD'];
      if (prodId == null) {
        throw StateError('ADMOB_INTERSTITIAL_AD_UNIT_ID_PROD not set in .env file');
      }
      return prodId;
    }
  }

  /// AdMob 보상형 광고 ID 반환 (환경에 따라)
  static String get admobRewardedAdUnitId {
    if (kDebugMode) {
      final devId = dotenv.env['ADMOB_REWARDED_AD_UNIT_ID_DEV'];
      if (devId == null) {
        throw StateError('ADMOB_REWARDED_AD_UNIT_ID_DEV not set in .env file');
      }
      return devId;
    } else {
      final prodId = dotenv.env['ADMOB_REWARDED_AD_UNIT_ID_PROD'];
      if (prodId == null) {
        throw StateError('ADMOB_REWARDED_AD_UNIT_ID_PROD not set in .env file');
      }
      return prodId;
    }
  }

  // ===== Firebase 키값 getter 메서드들 =====

  /// Firebase API Key 반환 (환경에 따라)
  static String get firebaseApiKey {
    if (kDebugMode) {
      final devKey = dotenv.env['FIREBASE_API_KEY_PROD'];
      if (devKey == null) {
        throw StateError('FIREBASE_API_KEY_DEV not set in .env file');
      }
      return devKey;
    } else {
      final prodKey = dotenv.env['FIREBASE_API_KEY_PROD'];
      if (prodKey == null) {
        throw StateError('FIREBASE_API_KEY_PROD not set in .env file');
      }
      return prodKey;
    }
  }

  /// Firebase App ID 반환 (환경에 따라)
  static String get firebaseAppId {
    if (kDebugMode) {
      final devId = dotenv.env['FIREBASE_APP_ID_PROD'];
      if (devId == null) {
        throw StateError('FIREBASE_APP_ID_DEV not set in .env file');
      }
      return devId;
    } else {
      final prodId = dotenv.env['FIREBASE_APP_ID_PROD'];
      if (prodId == null) {
        throw StateError('FIREBASE_APP_ID_PROD not set in .env file');
      }
      return prodId;
    }
  }

  /// Firebase Project ID 반환 (환경에 따라)
  static String get firebaseProjectId {
    if (kDebugMode) {
      final devId = dotenv.env['FIREBASE_PROJECT_ID_PROD'];
      if (devId == null) {
        throw StateError('FIREBASE_PROJECT_ID_DEV not set in .env file');
      }
      return devId;
    } else {
      final prodId = dotenv.env['FIREBASE_PROJECT_ID_PROD'];
      if (prodId == null) {
        throw StateError('FIREBASE_PROJECT_ID_PROD not set in .env file');
      }
      return prodId;
    }
  }

  /// Firebase Messaging Sender ID 반환 (환경에 따라)
  static String get firebaseMessagingSenderId {
    if (kDebugMode) {
      final devId = dotenv.env['FIREBASE_MESSAGING_SENDER_ID_PROD'];
      if (devId == null) {
        throw StateError('FIREBASE_MESSAGING_SENDER_ID_DEV not set in .env file');
      }
      return devId;
    } else {
      final prodId = dotenv.env['FIREBASE_MESSAGING_SENDER_ID_PROD'];
      if (prodId == null) {
        throw StateError('FIREBASE_MESSAGING_SENDER_ID_PROD not set in .env file');
      }
      return prodId;
    }
  }

  /// Firebase Storage Bucket 반환 (환경에 따라)
  static String get firebaseStorageBucket {
    if (kDebugMode) {
      final devBucket = dotenv.env['FIREBASE_STORAGE_BUCKET_PROD'];
      if (devBucket == null) {
        throw StateError('FIREBASE_STORAGE_BUCKET_DEV not set in .env file');
      }
      return devBucket;
    } else {
      final prodBucket = dotenv.env['FIREBASE_STORAGE_BUCKET_PROD'];
      if (prodBucket == null) {
        throw StateError('FIREBASE_STORAGE_BUCKET_PROD not set in .env file');
      }
      return prodBucket;
    }
  }

  /// Firebase Auth Domain 반환 (환경에 따라)
  static String get firebaseAuthDomain {
    if (kDebugMode) {
      final devDomain = dotenv.env['FIREBASE_AUTH_DOMAIN_PROD'];
      if (devDomain == null) {
        throw StateError('FIREBASE_AUTH_DOMAIN_DEV not set in .env file');
      }
      return devDomain;
    } else {
      final prodDomain = dotenv.env['FIREBASE_AUTH_DOMAIN_PROD'];
      if (prodDomain == null) {
        throw StateError('FIREBASE_AUTH_DOMAIN_PROD not set in .env file');
      }
      return prodDomain;
    }
  }

  /// Firebase Measurement ID 반환 (환경에 따라)
  static String get firebaseMeasurementId {
    if (kDebugMode) {
      final devId = dotenv.env['FIREBASE_MEASUREMENT_ID_PROD'];
      if (devId == null) {
        throw StateError('FIREBASE_MEASUREMENT_ID_DEV not set in .env file');
      }
      return devId;
    } else {
      final prodId = dotenv.env['FIREBASE_MEASUREMENT_ID_PROD'];
      if (prodId == null) {
        throw StateError('FIREBASE_MEASUREMENT_ID_PROD not set in .env file');
      }
      return prodId;
    }
  }

  // ===== Google Sign-In Client ID getter 메서드들 =====

  /// Google Sign-In Web Client ID 반환
  static String get googleSignInWebClientId {
    final clientId = dotenv.env['GOOGLE_SIGN_IN_CLIENT_ID_WEB'];
    if (clientId == null) {
      throw StateError('GOOGLE_SIGN_IN_CLIENT_ID_WEB not set in .env file');
    }
    return clientId;
  }

  /// Google Sign-In Android Client ID 반환
  static String get googleSignInAndroidClientId {
    final clientId = dotenv.env['GOOGLE_SIGN_IN_CLIENT_ID_ANDROID'];
    if (clientId == null) {
      throw StateError('GOOGLE_SIGN_IN_CLIENT_ID_ANDROID not set in .env file');
    }
    return clientId;
  }

  /// Google Sign-In iOS Client ID 반환
  static String get googleSignInIosClientId {
    final clientId = dotenv.env['GOOGLE_SIGN_IN_CLIENT_ID_IOS'];
    if (clientId == null) {
      throw StateError('GOOGLE_SIGN_IN_CLIENT_ID_IOS not set in .env file');
    }
    return clientId;
  }
}
