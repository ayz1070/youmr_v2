import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../auth/di/auth_module.dart';
import '../../../auth/presentation/providers/notifier/auth_notifier.dart';

/// 출석 체크 알림 전송 페이지
class AttendanceNotificationPage extends ConsumerStatefulWidget {
  const AttendanceNotificationPage({super.key});

  @override
  ConsumerState<AttendanceNotificationPage> createState() => _AttendanceNotificationPageState();
}

class _AttendanceNotificationPageState extends ConsumerState<AttendanceNotificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  String _selectedDayOfWeek = '금';
  bool _isLoading = false;
  bool _testMode = false;

  final List<String> _dayOfWeeks = ['일', '월', '화', '수', '목', '금', '토'];

  @override
  void initState() {
    super.initState();
    // 기본 메시지 설정
    _messageController.text = '금요일 오후 6시에 출석 체크를 해주세요!';
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  /// 요일 변경 시 메시지 업데이트
  void _onDayOfWeekChanged(String? newValue) {
    if (newValue != null) {
      setState(() {
        _selectedDayOfWeek = newValue;
        _messageController.text = '${newValue}요일 오후 6시에 출석 체크를 해주세요!';
      });
    }
  }

  /// 출석 체크 알림 전송
  Future<void> _sendAttendanceNotification() async {
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
      const functionUrl = 'https://us-central1-youmr-v2.cloudfunctions.net/sendManualAttendanceNotification';

      final response = await http.post(
        Uri.parse(functionUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'adminUserId': currentUser.uid,
          'dayOfWeek': _selectedDayOfWeek,
          'customMessage': _messageController.text.trim(),
          'testMode': _testMode,
        }),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        
        if (mounted) {
          String message = '${_selectedDayOfWeek}요일 출석 체크 알림이 전송되었습니다.\n'
              '성공: ${result['successCount']}, 실패: ${result['failureCount']}\n'
              '총 수신자: ${result['totalRecipients']}명';
          
          // 사용자 타입별 통계 표시
          if (result['userTypeStats'] != null) {
            final userTypeStats = Map<String, dynamic>.from(result['userTypeStats']);
            if (userTypeStats.isNotEmpty) {
              message += '\n\n사용자 타입별 수신자:';
              userTypeStats.forEach((userType, count) {
                String koreanType = '';
                switch (userType) {
                  case 'admin':
                    koreanType = '관리자';
                    break;
                  case 'offline_member':
                    koreanType = '오프라인 회원';
                    break;
                  case 'online_member':
                    koreanType = '온라인 회원';
                    break;
                  default:
                    koreanType = userType;
                }
                message += '\n• $koreanType: ${count}명';
              });
            }
          }
          
          if (result['testMode'] == true) {
            message += '\n\n(테스트 모드로 모든 사용자에게 전송됨)';
          }
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 8),
            ),
          );
          
          // 성공 시 메시지 초기화
          _messageController.text = '${_selectedDayOfWeek}요일 오후 6시에 출석 체크를 해주세요!';
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
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.green[700]),
                          const SizedBox(width: 8),
                          Text(
                            '출석 체크 알림 전송',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '• 선택한 요일에 해당하는 사용자들에게 출석 체크 알림을 전송합니다.\n'
                        '• 사용자의 dayOfWeek 필드에 따라 해당 요일 사용자들에게 전송됩니다.\n'
                        '• 관리자(admin)와 오프라인 회원(offline_member) 모두에게 전송됩니다.\n'
                        '• 매주 해당 요일 전날 오후 6시에 자동으로 전송되며, 필요시 수동으로도 전송할 수 있습니다.\n'
                        '• 메시지를 수정하여 커스텀 알림을 보낼 수 있습니다.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green[700],
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
                              '활성화하면 모든 사용자에게 전송됩니다. (dayOfWeek 필드 무시)',
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

                // 요일 선택
                Text(
                  '출석 요일 선택',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedDayOfWeek,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.green[400]!),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  items: _dayOfWeeks.map((day) {
                    return DropdownMenuItem<String>(
                      value: day,
                      child: Text('${day}요일'),
                    );
                  }).toList(),
                  onChanged: _onDayOfWeekChanged,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '요일을 선택해주세요';
                    }
                    return null;
                  },
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
                    hintText: '출석 체크 알림 메시지를 입력하세요',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.green[400]!),
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
                    onPressed: _isLoading ? null : _sendAttendanceNotification,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
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
                        : Text(
                            '${_selectedDayOfWeek}요일 출석 체크 알림 전송',
                            style: const TextStyle(
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