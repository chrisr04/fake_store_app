import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/features/home/home.dart';
import 'package:fake_store_app/navigation/navigation.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    await AppConfig.init();
  });

  testWidgets('HomeSearchBar displays correctly and triggers navigation on tap',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: FakeNavigator.menuNavigatorKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Search'),
            ),
          ),
        ),
        home: const Scaffold(
          body: HomeSearchBar(),
        ),
      ),
    );

    expect(find.byType(HomeSearchBar), findsOneWidget);

    expect(find.text(StringValue.searchInFakeStore), findsOneWidget);

    await tester.tap(find.byType(FakeTextFieldSearch));

    await tester.pumpAndSettle();

    expect(find.text('Search'), findsOneWidget);
  });
}
