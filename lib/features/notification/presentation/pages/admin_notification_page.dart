import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youmr_v2/core/widgets/primary_app_bar.dart';
import 'package:youmr_v2/core/widgets/app_text_field.dart';
import 'package:youmr_v2/core/widgets/app_button.dart';
import 'package:youmr_v2/features/notification/domain/entities/send_notification_params.dart';
import 'package:youmr_v2/features/notification/presentation/providers/notification_provider.dart';

/// 관리자용 알림 전송 페이지
class AdminNotificationPage extends ConsumerStatefulWidget {
  const AdminNotificationPage({super.key});

  @override
  ConsumerState<AdminNotificationPage> createState() => _AdminNotificationPageState();
}

class _AdminNotificationPageState extends ConsumerState<AdminNotificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _userIdsController = TextEditingController();
  
  String _selectedType = 'general';
  String _selectedTarget = 'all'; // all, offline_member, specific
  bool _isLoading = false;

  final List<String> _notificationTypes = [
    'general',
    'attendance',
    'monthly_fee',
    'announcement',
  ];

  final List<Map<String, String>> _targetOptions = [
    {'value': 'all', 'label': '전체 사용자'},
    {'value': 'offline_member', 'label': '오프라인 회원 전체'},
    {'value': 'specific', 'label': '특정 사용자'},
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _userIdsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 대상 선택
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '알림 대상',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedTarget,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      items: _targetOptions.map((option) {
                        return DropdownMenuItem(
                          value: option['value'],
                          child: Text(option['label']!),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedTarget = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 알림 타입 선택
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '알림 타입',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedType,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      items: _notificationTypes.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(_getTypeDisplayName(type)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 알림 제목
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '알림 제목',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: _titleController,
                      labelText: '알림 제목',
                      hintText: '알림 제목을 입력하세요',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '알림 제목을 입력해주세요';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 알림 내용
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '알림 내용',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: _bodyController,
                      labelText: '알림 내용',
                      hintText: '알림 내용을 입력하세요',
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '알림 내용을 입력해주세요';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 특정 사용자 입력 (선택사항)
            if (_selectedTarget == 'specific')
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '대상 사용자',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '사용자 ID를 쉼표로 구분하여 입력하세요',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AppTextField(
                        controller: _userIdsController,
                        labelText: '대상 사용자',
                        hintText: '사용자 ID를 쉼표로 구분하여 입력 (예: user1,user2,user3)',
                        validator: (value) {
                          if (_selectedTarget == 'specific' && (value == null || value.trim().isEmpty)) {
                            return '대상 사용자를 입력해주세요';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            
            const SizedBox(height: 24),
            
            // 전송 버튼
            AppButton(
              text: _isLoading ? '전송 중...' : '알림 전송',
              onPressed: _isLoading ? null : _sendNotification,
              enabled: !_isLoading,
            ),
          ],
        ),
      ),
    );
  }

  /// 알림 전송
  Future<void> _sendNotification() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      List<String> userIds = [];

      // 대상에 따른 사용자 ID 수집
      if (_selectedTarget == 'specific') {
        // 특정 사용자
        userIds = _userIdsController.text
            .split(',')
            .map((id) => id.trim())
            .where((id) => id.isNotEmpty)
            .toList();
      } else if (_selectedTarget == 'offline_member') {
        // 오프라인 회원 전체
        final offlineMembers = await FirebaseFirestore.instance
            .collection('users')
            .where('userType', isEqualTo: 'offline_member')
            .get();
        
        userIds = offlineMembers.docs.map((doc) => doc.id).toList();
      }
      // _selectedTarget == 'all'인 경우 userIds는 빈 배열로 유지 (전체 전송)

      final params = SendNotificationParams(
        title: _titleController.text.trim(),
        body: _bodyController.text.trim(),
        type: _selectedType,
        userIds: userIds,
        data: {
          'type': _selectedType,
          'target': _selectedTarget,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );

      final result = await ref.read(notificationProvider.notifier).sendPushNotification(params);

      result.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('알림 전송 실패: ${failure.message}'),
              backgroundColor: Colors.red,
            ),
          );
        },
        (_) {
          String targetText = '';
          switch (_selectedTarget) {
            case 'all':
              targetText = '전체 사용자';
              break;
            case 'offline_member':
              targetText = '오프라인 회원 전체';
              break;
            case 'specific':
              targetText = '특정 사용자';
              break;
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('알림이 성공적으로 전송되었습니다! (대상: $targetText)'),
              backgroundColor: Colors.green,
            ),
          );
          
          // 폼 초기화
          _titleController.clear();
          _bodyController.clear();
          _userIdsController.clear();
          setState(() {
            _selectedType = 'general';
            _selectedTarget = 'all';
          });
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('알림 전송 중 오류가 발생했습니다: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 알림 타입 표시 이름 반환
  String _getTypeDisplayName(String type) {
    switch (type) {
      case 'general':
        return '일반 알림';
      case 'attendance':
        return '출석 관련';
      case 'monthly_fee':
        return '회비 관련';
      case 'announcement':
        return '공지사항';
      default:
        return type;
    }
  }
} 