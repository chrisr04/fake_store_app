import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() async {
    await AppConfig.initAssets();
  });

  testWidgets('NotFoundPage renders correctly and button works',
      (WidgetTester tester) async {
    final FakeNavigatorObserver menuNavigatorObserver = FakeNavigatorObserver();
    final FakeNavigatorObserver rootNavigatorObserver = FakeNavigatorObserver();

    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: FakeNavigator.menuNavigatorKey,
        home: const NotFoundPage(navigateFromMenu: true),
        navigatorObservers: [menuNavigatorObserver],
      ),
    );

    expect(find.text(StringValue.error), findsOneWidget);
    expect(find.text(StringValue.routeNotFound), findsOneWidget);
    expect(find.text(StringValue.pleaseCheckThePath), findsOneWidget);
    expect(find.text(StringValue.back), findsOneWidget);

    await tester.tap(find.text(StringValue.back));
    await tester.pumpAndSettle();

    expect(menuNavigatorObserver.didPopCount, 1);

    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: FakeNavigator.rootNavigatorKey,
        home: const NotFoundPage(navigateFromMenu: false),
        navigatorObservers: [rootNavigatorObserver],
      ),
    );

    await tester.tap(find.text(StringValue.back));
    await tester.pumpAndSettle();

    expect(rootNavigatorObserver.didPopCount, 1);
  });
}

class FakeNavigatorObserver extends NavigatorObserver {
  int didPopCount = 0;

  @override
  void didPop(Route route, Route? previousRoute) {
    didPopCount++;
    super.didPop(route, previousRoute);
  }
}
