import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../constants/app_logger.dart';
import '../config/env_config.dart';

/// AdMob 서비스를 관리하는 클래스
class AdMobService {
  static final AdMobService _instance = AdMobService._internal();
  factory AdMobService() => _instance;
  AdMobService._internal();

  /// AdMob 초기화 여부
  bool _isInitialized = false;

  // AdMob Application ID는 AndroidManifest.xml에서 관리됨

  /// 배너 광고 ID (환경변수에서 가져옴)
  String get _bannerAdUnitId => EnvConfig.admobBannerAdUnitId;

  /// 출석 배너 광고 ID (환경변수에서 가져옴)
  String get _attendanceBannerAdUnitId => EnvConfig.admobAttendanceBannerAdUnitId;

  /// 전면 광고 ID (환경변수에서 가져옴)
  String get _interstitialAdUnitId => EnvConfig.admobInterstitialAdUnitId;

  /// 보상형 광고 ID (환경변수에서 가져옴)
  String get _rewardedAdUnitId => EnvConfig.admobRewardedAdUnitId;

  /// AdMob 초기화
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      await MobileAds.instance.initialize();
      _isInitialized = true;
      AppLogger.i('AdMob 초기화 완료');
    } catch (e) {
      AppLogger.e('AdMob 초기화 실패: $e');
    }
  }

  /// 배너 광고 ID 반환
  String get bannerAdUnitId => _bannerAdUnitId;

  /// 전면 광고 ID 반환
  String get interstitialAdUnitId => _interstitialAdUnitId;

  /// 보상형 광고 ID 반환
  String get rewardedAdUnitId => _rewardedAdUnitId;

  /// 배너 광고 로드
  Future<BannerAd?> loadBannerAd() async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      final BannerAd bannerAd = BannerAd(
        adUnitId: bannerAdUnitId,
        size: AdSize.banner,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            AppLogger.i('배너 광고 로드 완료');
          },
          onAdFailedToLoad: (ad, error) {
            AppLogger.e('배너 광고 로드 실패: $error');
            ad.dispose();
          },
        ),
      );

      await bannerAd.load();
      return bannerAd;
    } catch (e) {
      AppLogger.e('배너 광고 로드 중 오류: $e');
      return null;
    }
  }

  /// 출석 배너 광고 로드
  Future<BannerAd?> loadAttendanceBannerAd() async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      final BannerAd bannerAd = BannerAd(
        adUnitId: _attendanceBannerAdUnitId,
        size: AdSize.banner,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            AppLogger.i('출석 배너 광고 로드 완료');
          },
          onAdFailedToLoad: (ad, error) {
            AppLogger.e('출석 배너 광고 로드 실패: $error');
            ad.dispose();
          },
        ),
      );

      await bannerAd.load();
      return bannerAd;
    } catch (e) {
      AppLogger.e('출석 배너 광고 로드 중 오류: $e');
      return null;
    }
  }

  /// 전면 광고 로드
  Future<InterstitialAd?> loadInterstitialAd() async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      InterstitialAd? interstitialAd;
      await InterstitialAd.load(
        adUnitId: interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            AppLogger.i('전면 광고 로드 완료');
            interstitialAd = ad;
          },
          onAdFailedToLoad: (error) {
            AppLogger.e('전면 광고 로드 실패: $error');
          },
        ),
      );
      return interstitialAd;
    } catch (e) {
      AppLogger.e('전면 광고 로드 중 오류: $e');
      return null;
    }
  }

  /// 보상형 광고 로드
  Future<RewardedAd?> loadRewardedAd() async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      RewardedAd? rewardedAd;
      await RewardedAd.load(
        adUnitId: rewardedAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            AppLogger.i('보상형 광고 로드 완료');
            rewardedAd = ad;
          },
          onAdFailedToLoad: (error) {
            AppLogger.e('보상형 광고 로드 실패: $error');
          },
        ),
      );
      return rewardedAd;
    } catch (e) {
      AppLogger.e('보상형 광고 로드 중 오류: $e');
      return null;
    }
  }

  /// 전면 광고 표시
  Future<bool> showInterstitialAd() async {
    final interstitialAd = await loadInterstitialAd();
    if (interstitialAd != null) {
      await interstitialAd.show();
      return true;
    }
    return false;
  }

  /// 보상형 광고 표시
  Future<bool> showRewardedAd({
    required Function() onRewarded,
  }) async {
    final rewardedAd = await loadRewardedAd();
    if (rewardedAd != null) {
      rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          AppLogger.e('보상형 광고 표시 실패: $error');
          ad.dispose();
        },
      );

      await rewardedAd.show(
        onUserEarnedReward: (ad, reward) {
          onRewarded();
        },
      );
      return true;
    }
    return false;
  }
} 