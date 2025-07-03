import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../main/presentation/pages/main_navigation_page.dart';

/// 글쓰기(게시글 작성) 페이지
class WritePage extends StatefulWidget {
  const WritePage({super.key});

  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _youtubeController = TextEditingController();
  String _category = '자유';
  bool _isLoading = false;

  final List<String> _categories = ['자유', '신청곡', '영상'];

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('로그인 필요');
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      final userData = userDoc.data() ?? {};
      await FirebaseFirestore.instance.collection('posts').add({
        'title': _titleController.text.trim(),
        'content': _contentController.text.trim(),
        'youtubeUrl': _youtubeController.text.trim(),
        'category': _category,
        'authorId': user.uid,
        'authorNickname': userData['nickname'] ?? '',
        'authorProfileUrl': userData['profileImageUrl'] ?? '',
        'likes': [],
        'likesCount': 0,
        'isNotice': false,
        'isDeleted': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const MainNavigationPage(),
            settings: const RouteSettings(arguments: {'showPostSuccess': true}),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('게시글 등록에 실패했습니다.')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('글쓰기')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    DropdownButtonFormField<String>(
                      value: _category,
                      items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                      onChanged: (v) => setState(() => _category = v ?? '자유'),
                      decoration: const InputDecoration(labelText: '카테고리'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: '제목'),
                      validator: (v) => v == null || v.trim().isEmpty ? '제목을 입력해 주세요.' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _contentController,
                      decoration: const InputDecoration(labelText: '내용'),
                      maxLines: 6,
                      validator: (v) => v == null || v.trim().isEmpty ? '내용을 입력해 주세요.' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _youtubeController,
                      decoration: const InputDecoration(labelText: '유튜브 링크(선택)'),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submit,
                        child: const Text('등록'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _youtubeController.dispose();
    super.dispose();
  }
} 