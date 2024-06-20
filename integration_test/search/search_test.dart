import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../auth/login_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Should search products with de entry query', (tester) async {
    await loginTest(
      tester,
      username: 'mor_2314',
      password: '83r5^_',
    );
    await searchTest(
      tester,
      query: 'Sandisk',
    );
  });
}

Future<void> searchTest(
  WidgetTester tester, {
  required String query,
}) async {
  final searchAppBarFinder = find.byKey(KeyValue.homeSearchAppBar);

  await tester.tap(searchAppBarFinder);
  await tester.pumpAndSettle();

  expect(find.text(StringValue.findWhatYouLikeMost), findsOneWidget);

  final searchInputFinder = find.byKey(KeyValue.searchQueryInput);

  expect(searchInputFinder, findsOneWidget);

  await tester.enterText(searchInputFinder, query);
  await tester.testTextInput.receiveAction(TextInputAction.search);
  await tester.pumpAndSettle();

  expect(find.byType(FakeHorizontalProductCard), findsAtLeast(1));

  await Future.delayed(const Duration(seconds: 1));
}
