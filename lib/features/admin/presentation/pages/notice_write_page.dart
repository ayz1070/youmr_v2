import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youmr_v2/core/widgets/app_text_field.dart';
import 'package:youmr_v2/core/widgets/app_button.dart';

/// 공지글 작성 페이지
class NoticeWritePage extends StatefulWidget {
  const NoticeWritePage({super.key});

  @override
  State<NoticeWritePage> createState() => _NoticeWritePageState();
}

class _NoticeWritePageState extends State<NoticeWritePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _youtubeUrlController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _youtubeUrlController.dispose();
    super.dispose();
  }

  /// 공지글 작성
  Future<void> _writeNotice() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('사용자 정보를 찾을 수 없습니다.');
      }

      // 사용자 정보 조회
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!userDoc.exists) {
        throw Exception('사용자 정보를 찾을 수 없습니다.');
      }

      final userData = userDoc.data()!;
      final authorNickname = userData['nickname'] ?? '관리자';
      final authorProfileUrl = userData['profileImageUrl'] ?? '';

      // 공지글 데이터
      final noticeData = {
        'title': _titleController.text.trim(),
        'content': _contentController.text.trim(),
        'authorNickname': authorNickname,
        'authorProfileUrl': authorProfileUrl,
        'authorUid': user.uid,
        'isNotice': true, // 공지글 플래그
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'likes': [],
        'likesCount': 0,
        'commentsCount': 0,
      };

      // YouTube URL이 있으면 추가
      if (_youtubeUrlController.text.trim().isNotEmpty) {
        noticeData['youtubeUrl'] = _youtubeUrlController.text.trim();
      }

      // Firestore에 공지글 저장
      await FirebaseFirestore.instance
          .collection('posts')
          .add(noticeData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('공지글이 성공적으로 작성되었습니다!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop(true); // 성공 시 true 반환
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('공지글 작성 실패: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('공지글 작성'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 제목 입력
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '공지글 제목',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: _titleController,
                      labelText: '제목',
                      hintText: '공지글 제목을 입력하세요',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '제목을 입력해주세요';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 내용 입력
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '공지글 내용',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: _contentController,
                      labelText: '내용',
                      hintText: '공지글 내용을 입력하세요',
                      maxLines: 8,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '내용을 입력해주세요';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // YouTube URL 입력 (선택사항)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'YouTube URL (선택사항)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '관련 YouTube 영상이 있다면 URL을 입력하세요',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: _youtubeUrlController,
                      labelText: 'YouTube URL',
                      hintText: 'https://www.youtube.com/watch?v=...',
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 작성 버튼
            AppButton(
              text: _isLoading ? '작성 중...' : '공지글 작성',
              onPressed: _isLoading ? null : _writeNotice,
              enabled: !_isLoading,
            ),
          ],
        ),
      ),
    );
  }
} 