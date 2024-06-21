import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/features/support/support.dart';

void main() {
  setUpAll(() async {
    await AppConfig.init();
  });

  testWidgets('FastSolutionsList renders correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FastSolutionsList(),
        ),
      ),
    );

    expect(find.text(StringValue.fastSolutions), findsOneWidget);

    expect(find.text(StringValue.problemWithOrders), findsOneWidget);
    expect(find.text(StringValue.problemWithBillingData), findsOneWidget);
    expect(find.text(StringValue.problemWithAddress), findsOneWidget);
    expect(find.text(StringValue.tutorials), findsOneWidget);

    expect(find.byType(FakeInformationCard), findsWidgets);

    await tester.tap(find.text(StringValue.problemWithOrders));
    await tester.tap(find.text(StringValue.problemWithBillingData));
    await tester.tap(find.text(StringValue.problemWithAddress));
    await tester.tap(find.text(StringValue.tutorials));
  });
}
