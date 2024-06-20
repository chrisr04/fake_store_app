import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/features/support/support.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SupportHeader widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SupportHeader(),
        ),
      ),
    );

    expect(find.text(StringValue.helloDoYouNeedHelp), findsOneWidget);

    expect(find.text(StringValue.weAreHereForHelpYouContactUs), findsOneWidget);

    expect(find.byType(FakeAvatarStack), findsOneWidget);
  });
}
