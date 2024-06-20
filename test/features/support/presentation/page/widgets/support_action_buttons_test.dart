import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/features/support/support.dart';

void main() {
  testWidgets('SupportActionButtons displays buttons with correct labels',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SupportActionButtons(),
        ),
      ),
    );

    final writeButtonFinder = find.text(StringValue.writeUs);
    final callButtonFinder = find.text(StringValue.callUs);

    expect(writeButtonFinder, findsOneWidget);
    expect(callButtonFinder, findsOneWidget);

    await tester.tap(callButtonFinder);
    await tester.pump();

    await tester.tap(writeButtonFinder);
    await tester.pump();
  });
}
