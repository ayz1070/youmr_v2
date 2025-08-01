import 'package:flutter/material.dart';
import 'package:youmr_v2/core/widgets/app_button.dart';
import '../widgets/voting_form_section.dart';
import '../controllers/voting_write_controller.dart';

/// 곡 등록 화면
class VotingWritePage extends StatefulWidget {
  const VotingWritePage({super.key});

  @override
  State<VotingWritePage> createState() => _VotingWritePageState();
}

class _VotingWritePageState extends State<VotingWritePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final VotingWriteController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VotingWriteController();
    _controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  /// 투표 등록 처리
  Future<void> _handleRegisterVote() async {
    if (!_controller.validateForm(_formKey)) return;
    
    try {
      await _controller.registerVote();
      if (!mounted) return;
      
      // 성공 시 true를 반환하여 새로고침 필요함을 알림
      Navigator.of(context).pop(true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('곡이 등록되었습니다.')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('등록 실패: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('곡 등록'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 폼 섹션
            VotingFormSection(
              formKey: _formKey,
              titleController: _controller.titleController,
              artistController: _controller.artistController,
              youtubeController: _controller.youtubeController,
            ),
            // 등록 버튼
            AppButton(
              text: '등록',
              onPressed: _handleRegisterVote,
            ),
          ],
        ),
      ),
    );
  }
} 