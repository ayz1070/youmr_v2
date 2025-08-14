import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../auth/di/auth_module.dart';
import '../../../auth/presentation/providers/notifier/auth_notifier.dart';

/// 회비 알림 전송 페이지
class FeeNotificationPage extends ConsumerStatefulWidget {
  const FeeNotificationPage({super.key});

  @override
  ConsumerState<FeeNotificationPage> createState() => _FeeNotificationPageState();
}

class _FeeNotificationPageState extends ConsumerState<FeeNotificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  bool _isLoading = false;
  bool _testMode = false;

  @override
  void initState() {
    super.initState();
    // 기본 메시지 설정
    _messageController.text = '이번 달 회비를 납부해 주세요. 감사합니다.';
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  /// 회비 알림 전송
  Future<void> _sendFeeNotification() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final currentUser = ref.read(authProvider).value;
      if (currentUser == null) {
        throw Exception('사용자 정보를 찾을 수 없습니다.');
      }

      // Firebase Functions URL
      const functionUrl = 'https://us-central1-youmr-v2.cloudfunctions.net/sendManualFeeNotification';

      final response = await http.post(
        Uri.parse(functionUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'adminUserId': currentUser.uid,
          'customMessage': _messageController.text.trim(),
          'testMode': _testMode,
        }),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        
        if (mounted) {
          String message = '회비 알림이 전송되었습니다.\n'
              '성공: ${result['successCount']}, 실패: ${result['failureCount']}\n'
              '총 수신자: ${result['totalRecipients']}명';
          
          if (result['testMode'] == true) {
            message += '\n(테스트 모드로 모든 사용자에게 전송됨)';
          }
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 8),
            ),
          );
          
          // 성공 시 메시지 초기화
          _messageController.text = '이번 달 회비를 납부해 주세요. 감사합니다.';
        }
      } else if (response.statusCode == 403) {
        throw Exception('관리자 권한이 없습니다. 관리자 계정으로 로그인해주세요.');
      } else if (response.statusCode == 400) {
        throw Exception('잘못된 요청입니다. 필수 정보를 확인해주세요.');
      } else {
        final errorData = json.decode(response.body);
        throw Exception('알림 전송에 실패했습니다: ${errorData['error'] ?? response.statusCode}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('오류가 발생했습니다: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
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
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 안내 텍스트
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.blue[700]),
                          const SizedBox(width: 8),
                          Text(
                            '회비 알림 전송',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '• admin과 offline_member 타입의 모든 사용자에게 회비 알림을 전송합니다.\n'
                        '• 매월 1일 오후 12시에 자동으로 전송되며, 필요시 수동으로도 전송할 수 있습니다.\n'
                        '• 메시지를 수정하여 커스텀 알림을 보낼 수 있습니다.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 테스트 모드 스위치
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.science, color: Colors.orange[700]),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '테스트 모드',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '활성화하면 모든 사용자에게 전송됩니다. (admin/offline_member 필드 무시)',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.orange[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: _testMode,
                        onChanged: (value) {
                          setState(() {
                            _testMode = value;
                          });
                        },
                        activeColor: Colors.orange[600],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 메시지 입력 필드
                Text(
                  '알림 메시지',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _messageController,
                  maxLines: 3,
                  minLines: 3,
                  decoration: InputDecoration(
                    hintText: '회비 알림 메시지를 입력하세요',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.blue[400]!),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return '메시지를 입력해주세요';
                    }
                    if (value.trim().length > 200) {
                      return '메시지는 200자 이내로 입력해주세요';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // 전송 버튼
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _sendFeeNotification,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isLoading
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              ),
                              SizedBox(width: 12),
                              Text('전송 중...'),
                            ],
                          )
                        : const Text(
                            '회비 알림 전송',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 16),

                // 주의사항
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning_amber_outlined, color: Colors.orange[700]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '주의: 한 번 전송된 알림은 취소할 수 없습니다.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.orange[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 