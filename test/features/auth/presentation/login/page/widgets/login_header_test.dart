import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_app/features/auth/auth.dart';

void main() {
  setUpAll(() async {
    await AppConfig.init();
  });

  group('LoginHeader', () {
    testWidgets('should displays all required elements',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoginHeader(),
          ),
        ),
      );

      final fakeImageFinder = find.byType(FakeImageAsset);
      expect(fakeImageFinder, findsOneWidget);

      final fakeTextFinder = find.text(StringValue.login);
      expect(fakeTextFinder, findsOneWidget);
    });
  });
}
