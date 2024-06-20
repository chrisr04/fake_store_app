import 'package:fake_store_app/common/common.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../auth/login_test.dart';
import '../search/search_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Should add given product to cart', (tester) async {
    await loginTest(
      tester,
      username: 'mor_2314',
      password: '83r5^_',
    );
    await addToCartTest(
      tester,
      productName: 'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
    );
  });
}

Future<void> addToCartTest(
  WidgetTester tester, {
  required String productName,
}) async {
  final menuHomeFinder = find.byKey(KeyValue.menuHomeIconBtn);

  await tester.tap(menuHomeFinder);
  await tester.pumpAndSettle();

  await searchTest(tester, query: productName);

  final addToCartTextFinder = find.text(StringValue.addToCart).first;

  await tester.tap(addToCartTextFinder);
  await tester.pumpAndSettle();

  await Future.delayed(const Duration(seconds: 1));
}
