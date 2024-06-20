import 'package:fake_store_app/common/common.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../auth/login_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Should navigate to the support page', (tester) async {
    await loginTest(
      tester,
      username: 'mor_2314',
      password: '83r5^_',
    );
    await supportTest(tester);
  });
}

Future<void> supportTest(WidgetTester tester) async {
  final menuSupportFinder = find.byKey(KeyValue.menuSupportIconBtn);

  await tester.tap(menuSupportFinder);
  await tester.pumpAndSettle();

  expect(find.text(StringValue.helloDoYouNeedHelp), findsWidgets);

  await Future.delayed(const Duration(seconds: 1));
}
