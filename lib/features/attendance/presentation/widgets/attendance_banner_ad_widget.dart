import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../../core/services/admob_service.dart';

/// 출석 화면 전용 배너 광고를 표시하는 위젯
class AttendanceBannerAdWidget extends StatefulWidget {
  const AttendanceBannerAdWidget({super.key});

  @override
  State<AttendanceBannerAdWidget> createState() => _AttendanceBannerAdWidgetState();
}

class _AttendanceBannerAdWidgetState extends State<AttendanceBannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  /// 출석 배너 광고 로드
  Future<void> _loadBannerAd() async {
    final bannerAd = await AdMobService().loadAttendanceBannerAd();
    if (bannerAd != null) {
      setState(() {
        _bannerAd = bannerAd;
        _isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded || _bannerAd == null) {
      return const SizedBox(
        height: 50,
        child: Center(
          child: Text(
            '출석 광고 로딩 중...',
            style: TextStyle(fontSize: 12),
          ),
        ),
      );
    }

    return SizedBox(
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}