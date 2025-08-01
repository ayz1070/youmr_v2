import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';

/// AdMob 서비스를 관리하는 클래스
class AdMobService {
  static final AdMobService _instance = AdMobService._internal();
  factory AdMobService() => _instance;
  AdMobService._internal();

  /// AdMob 초기화 여부
  bool _isInitialized = false;

  /// 테스트 광고 ID들
  static const String _testBannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111';
  static const String _testInterstitialAdUnitId = 'ca-app-pub-3940256099942544/1033173712';
  static const String _testRewardedAdUnitId = 'ca-app-pub-3940256099942544/5224354917';

  /// 실제 광고 ID들 (배포 시 사용)
  static const String _bannerAdUnitId = 'YOUR_BANNER_AD_UNIT_ID';
  static const String _interstitialAdUnitId = 'YOUR_INTERSTITIAL_AD_UNIT_ID';
  static const String _rewardedAdUnitId = 'YOUR_REWARDED_AD_UNIT_ID';

  /// AdMob 초기화
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      await MobileAds.instance.initialize();
      _isInitialized = true;
      debugPrint('AdMob 초기화 완료');
    } catch (e) {
      debugPrint('AdMob 초기화 실패: $e');
    }
  }

  /// 배너 광고 ID 반환
  String get bannerAdUnitId {
    return kDebugMode ? _testBannerAdUnitId : _bannerAdUnitId;
  }

  /// 전면 광고 ID 반환
  String get interstitialAdUnitId {
    return kDebugMode ? _testInterstitialAdUnitId : _interstitialAdUnitId;
  }

  /// 보상형 광고 ID 반환
  String get rewardedAdUnitId {
    return kDebugMode ? _testRewardedAdUnitId : _rewardedAdUnitId;
  }

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
            debugPrint('배너 광고 로드 완료');
          },
          onAdFailedToLoad: (ad, error) {
            debugPrint('배너 광고 로드 실패: $error');
            ad.dispose();
          },
        ),
      );

      await bannerAd.load();
      return bannerAd;
    } catch (e) {
      debugPrint('배너 광고 로드 중 오류: $e');
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
            debugPrint('전면 광고 로드 완료');
            interstitialAd = ad;
          },
          onAdFailedToLoad: (error) {
            debugPrint('전면 광고 로드 실패: $error');
          },
        ),
      );
      return interstitialAd;
    } catch (e) {
      debugPrint('전면 광고 로드 중 오류: $e');
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
            debugPrint('보상형 광고 로드 완료');
            rewardedAd = ad;
          },
          onAdFailedToLoad: (error) {
            debugPrint('보상형 광고 로드 실패: $error');
          },
        ),
      );
      return rewardedAd;
    } catch (e) {
      debugPrint('보상형 광고 로드 중 오류: $e');
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
          debugPrint('보상형 광고 표시 실패: $error');
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