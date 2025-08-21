import 'package:flutter/material.dart';
import '../services/admob_service.dart';

/// 보상형 광고를 표시하는 버튼 위젯
class RewardedAdButton extends StatefulWidget {
  final String text;
  final String rewardText;
  final VoidCallback? onRewarded;
  final VoidCallback? onAdFailed;
  final ButtonStyle? style;
  final Widget? child;

  const RewardedAdButton({
    super.key,
    this.text = '보상형 광고 보기',
    this.rewardText = '보상 획득!',
    this.onRewarded,
    this.onAdFailed,
    this.style,
    this.child,
  });

  @override
  State<RewardedAdButton> createState() => _RewardedAdButtonState();
}

class _RewardedAdButtonState extends State<RewardedAdButton> {
  bool _isLoading = false;

  /// 보상형 광고 표시
  Future<void> _showRewardedAd() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final success = await AdMobService().showRewardedAd(
        onRewarded: () {
          widget.onRewarded?.call();
          _showRewardSnackBar();
        },
      );
      
      if (!success) {
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

  /// 보상 획득 스낵바 표시
  void _showRewardSnackBar() {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.rewardText),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _showRewardedAd,
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