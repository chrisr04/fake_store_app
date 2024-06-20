import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_app/features/auth/auth.dart';

void main() {
  testWidgets('RegisterTitle widget has correct text',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RegisterTitle(),
        ),
      ),
    );

    final textFinder = find.byType(FakeTextHeading3);
    expect(textFinder, findsOneWidget);

    final textWidget = tester.widget<FakeTextHeading3>(textFinder);
    expect(textWidget.label, StringValue.registry);
  });
}
