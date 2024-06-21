import 'package:fake_store_app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/navigation/navigation.dart';
import 'package:fake_store_app/features/catalog/catalog.dart';

void main() {
  setUpAll(() async {
    await AppConfig.init();
  });

  group('CategoriesPage', () {
    testWidgets('CategoriesPage displays correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: FakeNavigator.menuNavigatorKey,
          home: const CategoriesPage(),
        ),
      );

      expect(find.byType(FakeSearchAppBar), findsOneWidget);
      expect(find.byType(FakeHorizontalImageCard), findsWidgets);
      expect(find.text(StringValue.electronics), findsOneWidget);
      expect(find.text(StringValue.womenClothing), findsOneWidget);
      expect(find.text(StringValue.menClothing), findsOneWidget);
      expect(find.text(StringValue.jewelery), findsOneWidget);
    });

    testWidgets('CategoriesPage navigates to electronics category',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: FakeNavigator.menuNavigatorKey,
          home: const CategoriesPage(),
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(
                child: Text('Electronics'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text(StringValue.electronics));
      await tester.pumpAndSettle();

      expect(find.text('Electronics'), findsOneWidget);
    });

    testWidgets('CategoriesPage navigates to men clothing category',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: FakeNavigator.menuNavigatorKey,
          home: const CategoriesPage(),
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(
                child: Text('Men clothing'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text(StringValue.menClothing));
      await tester.pumpAndSettle();

      expect(find.text('Men clothing'), findsOneWidget);
    });

    testWidgets('CategoriesPage navigates to women clothing category',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: FakeNavigator.menuNavigatorKey,
          home: const CategoriesPage(),
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(
                child: Text('Women clothing'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text(StringValue.womenClothing));
      await tester.pumpAndSettle();

      expect(find.text('Women clothing'), findsOneWidget);
    });

    testWidgets('CategoriesPage navigates to jewelery category',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: FakeNavigator.menuNavigatorKey,
          home: const CategoriesPage(),
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(
                child: Text('Jewelery'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text(StringValue.jewelery));
      await tester.pumpAndSettle();

      expect(find.text('Jewelery'), findsOneWidget);
    });

    testWidgets('CategoriesPage navigates to search page',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: FakeNavigator.menuNavigatorKey,
          home: const CategoriesPage(),
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(
                child: Text('Search'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FakeSearchAppBar));
      await tester.pumpAndSettle();

      expect(find.text('Search'), findsOneWidget);
    });
  });
}
