import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../auth/login_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Should navigate to detail of the category entry',
      (tester) async {
    await loginTest(
      tester,
      username: 'mor_2314',
      password: '83r5^_',
    );
    await categoryDetailTest(
      tester,
      category: StringValue.electronics,
    );
  });
}

Future<void> categoryDetailTest(
  WidgetTester tester, {
  required String category,
}) async {
  final menuCatalogFinder = find.byKey(KeyValue.menuCatalogIconBtn);

  await tester.tap(menuCatalogFinder);
  await tester.pumpAndSettle();

  final categoryFinder = find.text(category);

  expect(categoryFinder, findsOneWidget);

  await tester.tap(categoryFinder);
  await tester.pumpAndSettle();

  expect(find.byType(FakeHorizontalProductCard), findsWidgets);

  await Future.delayed(const Duration(seconds: 1));
}
