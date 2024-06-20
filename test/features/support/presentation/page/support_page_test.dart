import 'package:fake_store_app/features/support/support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SupportPage contains required widgets',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SupportPage(),
      ),
    );
    expect(find.byType(SupportHeader), findsOneWidget);
    expect(find.byType(SupportActionButtons), findsOneWidget);
    expect(find.byType(FastSolutionsList), findsOneWidget);
  });
}
