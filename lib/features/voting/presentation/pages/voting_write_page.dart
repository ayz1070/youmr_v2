import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// 곡 등록 화면
class VotingWritePage extends StatefulWidget {
  const VotingWritePage({super.key});

  @override
  State<VotingWritePage> createState() => _VotingWritePageState();
}

class _VotingWritePageState extends State<VotingWritePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _artistController = TextEditingController();
  final TextEditingController _youtubeController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _artistController.dispose();
    _youtubeController.dispose();
    super.dispose();
  }

  Future<void> _registerVote() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('로그인 필요');
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      final userData = userDoc.data() ?? {};
      await FirebaseFirestore.instance.collection('votes').add({
        'title': _titleController.text.trim(),
        'artist': _artistController.text.trim(),
        'youtubeUrl': _youtubeController.text.trim(),
        'voteCount': 0,
        'createdAt': DateTime.now(),
        'createdBy': user.uid,
        'authorNickname': userData['nickname'] ?? '',
        'authorProfileUrl': userData['profileImageUrl'] ?? '',
      });
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('곡이 등록되었습니다.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('등록 실패: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('곡 등록'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 제목 입력
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: '제목'),
                validator: (value) =>
                    (value == null || value.trim().isEmpty) ? '제목을 입력해 주세요.' : null,
              ),
              const SizedBox(height: 16),
              // 가수 입력
              TextFormField(
                controller: _artistController,
                decoration: const InputDecoration(labelText: '가수'),
                validator: (value) =>
                    (value == null || value.trim().isEmpty) ? '가수를 입력해 주세요.' : null,
              ),
              const SizedBox(height: 16),
              // YouTube 링크 입력
              TextFormField(
                controller: _youtubeController,
                decoration: const InputDecoration(labelText: 'YouTube 링크 (선택)'),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _registerVote,
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('등록'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 