import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/features/search/search.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    await AppConfig.initAssets();
  });

  testWidgets('NoSearchMessage displays correct content',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NoSearchMessage(),
        ),
      ),
    );

    expect(find.byType(CustomScrollView), findsOneWidget);

    expect(find.byType(SliverFillRemaining), findsOneWidget);

    final fakeInformationTemplateFinder = find.byType(FakeInformationTemplate);
    expect(fakeInformationTemplateFinder, findsOneWidget);

    final fakeInformationTemplate = tester.widget<FakeInformationTemplate>(
      fakeInformationTemplateFinder,
    );
    expect(fakeInformationTemplate.imagePath, AssetValue.searchIllustrationPng);
    expect(fakeInformationTemplate.message, StringValue.findWhatYouLikeMost);
  });
}
