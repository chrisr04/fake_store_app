import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/features/search/presentation/page/search_page.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    await AppConfig.initAssets();
  });

  testWidgets('EmptyResultMessage displays the correct content',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: EmptyResultMessage(),
        ),
      ),
    );

    expect(find.byType(CustomScrollView), findsOneWidget);
    expect(find.byType(SliverFillRemaining), findsOneWidget);
    expect(find.byType(FakeInformationTemplate), findsOneWidget);

    final fakeInformationTemplate = tester.widget<FakeInformationTemplate>(
      find.byType(FakeInformationTemplate),
    );
    expect(
      fakeInformationTemplate.imagePath,
      AssetValue.emptySearchIllustrationPng,
    );
    expect(fakeInformationTemplate.message, StringValue.weCantFindResults);
  });
}
