import 'package:provider/provider.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_app/features/auth/auth.dart';
import 'package:fake_store_app/accessibility/accessibility.dart';

void main() {
  setUpAll(() async {
    await AppConfig.initAssets();
  });

  testWidgets('RegisterTitle widget has correct text',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      FutureProvider<RegisterSemantics>(
        create: (context) => RegisterSemantics.load(),
        initialData: RegisterSemantics.fromJson({}),
        child: const MaterialApp(
          home: Scaffold(
            body: RegisterTitle(),
          ),
        ),
      ),
    );

    final textFinder = find.byType(FakeTextHeading3);
    expect(textFinder, findsOneWidget);

    final textWidget = tester.widget<FakeTextHeading3>(textFinder);
    expect(textWidget.label, StringValue.registry);
  });
}
