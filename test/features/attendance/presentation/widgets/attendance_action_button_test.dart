import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youmr_v2/features/attendance/presentation/widgets/attendance_action_button.dart';

void main() {
  testWidgets('출석/불참 버튼 UI 및 클릭 동작', (tester) async {
    // Arrange
    bool tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: AttendanceActionButton(
          isChecked: false,
          onTap: () => tapped = true,
        ),
      ),
    );
    // Assert: 출석 텍스트, 체크 아이콘
    expect(find.text('출석'), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);
    // Act: 클릭
    await tester.tap(find.byType(AttendanceActionButton));
    // Assert: 콜백 호출
    expect(tapped, true);
  });

  testWidgets('불참 상태 UI', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AttendanceActionButton(
          isChecked: true,
          onTap: () {},
        ),
      ),
    );
    // 불참 텍스트, 마이너스 아이콘
    expect(find.text('불참'), findsOneWidget);
    expect(find.byIcon(Icons.remove), findsOneWidget);
  });
} 