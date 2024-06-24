import 'package:fake_store_app/accessibility/accessibility.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_app/features/catalog/catalog.dart';
import 'package:provider/provider.dart';

void main() {
  setUpAll(() async {
    await AppConfig.initAssets();
  });

  group('CategoryHeader', () {
    const String testCategory = 'testCategory';

    testWidgets('renders correctly with the given category',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        FutureProvider<CategoryDetailSemantics>(
          create: (context) => CategoryDetailSemantics.load(),
          initialData: CategoryDetailSemantics.fromJson({}),
          child: const MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [
                  CategoryHeader(category: testCategory),
                ],
              ),
            ),
          ),
        ),
      );

      final imageFinder = find.byType(FakeImageAsset);
      expect(imageFinder, findsOneWidget);
      final FakeImageAsset image = tester.widget(imageFinder);
      expect(image.path, CategoryHelper.categoryImage(testCategory));

      final textFinder = find.byType(FakeTextHeading6);
      expect(textFinder, findsOneWidget);
      final FakeTextHeading6 text = tester.widget(textFinder);
      expect(text.label, CategoryHelper.categoryName(testCategory));

      expect(find.byType(FakeSpacerM), findsOneWidget);
    });
  });
}
