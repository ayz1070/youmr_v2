import 'package:flutter/material.dart';
import '../services/admob_service.dart';

/// 전면 광고를 표시하는 버튼 위젯
class InterstitialAdButton extends StatefulWidget {
  final String text;
  final VoidCallback? onAdCompleted;
  final VoidCallback? onAdFailed;
  final ButtonStyle? style;
  final Widget? child;

  const InterstitialAdButton({
    super.key,
    this.text = '전면 광고 보기',
    this.onAdCompleted,
    this.onAdFailed,
    this.style,
    this.child,
  });

  @override
  State<InterstitialAdButton> createState() => _InterstitialAdButtonState();
}

class _InterstitialAdButtonState extends State<InterstitialAdButton> {
  bool _isLoading = false;

  /// 전면 광고 표시
  Future<void> _showInterstitialAd() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final success = await AdMobService().showInterstitialAd();
      
      if (success) {
        widget.onAdCompleted?.call();
      } else {
        widget.onAdFailed?.call();
      }
    } catch (e) {
      widget.onAdFailed?.call();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _showInterstitialAd,
      style: widget.style,
      child: _isLoading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : widget.child ?? Text(widget.text),
    );
  }
} 