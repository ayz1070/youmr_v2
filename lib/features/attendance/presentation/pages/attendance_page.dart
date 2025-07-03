import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

/// 출석 탭 페이지
class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final List<String> _days = ['월', '화', '수', '목', '금', '토', '일', '불참'];
  String get _weekKey {
    final now = DateTime.now();
    String weekStr = DateFormat('w', 'en_US').format(now);
    int weekOfYear;
    try {
      weekOfYear = int.parse(weekStr);
    } catch (_) {
      weekOfYear = 1; // 파싱 실패 시 기본값
    }
    return '${now.year}-$weekOfYear';
  }

  List<String> _mySelectedDays = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMyAttendance();
  }

  /// 내 출석 정보 불러오기
  Future<void> _loadMyAttendance() async {
    setState(() => _isLoading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      final doc = await FirebaseFirestore.instance
          .collection('attendance')
          .doc('${_weekKey}_${user.uid}')
          .get();
      final data = doc.data();
      if (data != null && data['selectedDays'] != null) {
        _mySelectedDays = List<String>.from(data['selectedDays']);
      }
    } catch (_) {}
    setState(() => _isLoading = false);
  }

  /// 출석 선택 BottomSheet
  void _showAttendanceSheet() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final result = await showModalBottomSheet<List<String>>(
      context: context,
      builder: (ctx) {
        List<String> tempSelected = List.from(_mySelectedDays);
        return StatefulBuilder(
          builder: (context, setModalState) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('출석할 요일을 선택하세요', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  children: _days.map((d) => FilterChip(
                    label: Text(d),
                    selected: tempSelected.contains(d),
                    onSelected: (selected) {
                      setModalState(() {
                        if (selected) {
                          if (d == '불참') {
                            tempSelected = ['불참'];
                          } else {
                            tempSelected.remove('불참');
                            tempSelected.add(d);
                          }
                        } else {
                          tempSelected.remove(d);
                        }
                      });
                    },
                  )).toList(),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.pop(ctx, tempSelected),
                  child: const Text('저장'),
                ),
              ],
            ),
          ),
        );
      },
    );
    if (result != null) {
      await _saveAttendance(result);
    }
  }

  /// 출석 정보 Firestore에 저장
  Future<void> _saveAttendance(List<String> days) async {
    setState(() => _isLoading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      final userData = userDoc.data() ?? {};
      await FirebaseFirestore.instance.collection('attendance').doc('${_weekKey}_${user.uid}').set({
        'weekKey': _weekKey,
        'userId': user.uid,
        'nickname': userData['nickname'] ?? '',
        'profileImageUrl': userData['profileImageUrl'] ?? '',
        'selectedDays': days,
        'lastUpdated': FieldValue.serverTimestamp(),
      });
      setState(() => _mySelectedDays = days);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('출석 정보가 저장되었습니다.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('출석 저장에 실패했습니다.')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// 요일별 참석자 스트림
  Stream<List<Map<String, dynamic>>> _attendeesStream(String day) {
    return FirebaseFirestore.instance
        .collection('attendance')
        .where('weekKey', isEqualTo: _weekKey)
        .where('selectedDays', arrayContains: day)
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 12, top: 4),
                  child: Text(_getCurrentWeekText(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                ..._days.where((d) => d != '불참').map((day) => Padding(
                  padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 2, bottom: 8),
                        child: Text('$day요일', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 14)),
                      ),
                      StreamBuilder<List<Map<String, dynamic>>>(
                        stream: _attendeesStream(day),
                        builder: (context, snapshot) {
                          final attendees = snapshot.data ?? [];
                          final isChecked = _mySelectedDays.contains(day);
                          return SizedBox(
                            height: 60,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: attendees.length + 1,
                              separatorBuilder: (_, __) => const SizedBox(width: 12),
                              itemBuilder: (context, idx) {
                                if (idx == 0) {
                                  // 출석 버튼 (체크/마이너스)
                                  return GestureDetector(
                                    onTap: _isLoading ? null : () async {
                                      if (!isChecked) {
                                        await _saveAttendance([..._mySelectedDays, day]);
                                      } else {
                                        final newDays = List<String>.from(_mySelectedDays)..remove(day);
                                        await _saveAttendance(newDays);
                                      }
                                      await _loadMyAttendance();
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: isChecked ? Theme.of(context).colorScheme.primary.withOpacity(0.12) : Theme.of(context).colorScheme.surface,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: isChecked ? Theme.of(context).colorScheme.primary : Theme.of(context).dividerColor,
                                              width: 1.5,
                                            ),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              isChecked ? Icons.remove : Icons.check,
                                              size: 22,
                                              color: isChecked ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurfaceVariant,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          isChecked ? '불참' : '출석',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                final a = attendees[idx - 1];
                                return Column(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.surface,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Theme.of(context).dividerColor, width: 1),
                                      ),
                                      child: ClipOval(
                                        child: a['profileImageUrl'] != null && a['profileImageUrl'] != ''
                                            ? Image.network(a['profileImageUrl'], fit: BoxFit.cover)
                                            : Image.asset('assets/images/default_profile.png', fit: BoxFit.cover),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    SizedBox(
                                      width: 40,
                                      child: Text(
                                        a['nickname'] ?? '',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )),
              ],
            ),
    );
  }

  String _getCurrentWeekText() {
    final now = DateTime.now();
    final weekStr = DateFormat('w', 'en_US').format(now);
    int weekOfYear;
    try {
      weekOfYear = int.parse(weekStr);
    } catch (_) {
      weekOfYear = 1;
    }
    final month = now.month;
    return '$month월 ${weekOfYear}주차';
  }
} 