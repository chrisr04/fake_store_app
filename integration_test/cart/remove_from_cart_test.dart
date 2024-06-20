import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../auth/login_test.dart';
import 'add_to_cart_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Should remove given product from cart', (tester) async {
    await loginTest(
      tester,
      username: 'mor_2314',
      password: '83r5^_',
    );
    await addToCartTest(
      tester,
      productName: 'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
    );
    await removeFromCartTest(
      tester,
      productName: 'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
    );
  });
}

Future<void> removeFromCartTest(
  WidgetTester tester, {
  required String productName,
}) async {
  final menuCartFinder = find.byKey(KeyValue.menuCartIconBtn);

  await tester.tap(menuCartFinder);
  await tester.pumpAndSettle();

  final productCardFinder = find.byWidgetPredicate(
    (widget) => widget is FakeShoppingCartCard && widget.title == productName,
  );

  await tester.scrollUntilVisible(
    productCardFinder,
    100.0,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pumpAndSettle();

  final deleteTextFinder = find.descendant(
    of: productCardFinder,
    matching: find.text(StringValue.delete),
  );

  await tester.tap(deleteTextFinder);
  await tester.pumpAndSettle();

  expect(deleteTextFinder, findsNothing);

  await Future.delayed(const Duration(seconds: 1));
}
