import 'package:fake_store_app/common/common.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:fake_store_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Should fill the form fields and Sign In',
    (tester) => loginTest(
      tester,
      username: 'mor_2314',
      password: '83r5^_',
    ),
  );
}

Future<void> loginTest(
  WidgetTester tester, {
  required String username,
  required String password,
}) async {
  app.main();

  await tester.pumpAndSettle();

  expect(find.text(StringValue.welcome), findsOneWidget);

  await tester.tap(find.byKey(KeyValue.welcomeSignInBtn));
  await tester.pumpAndSettle();

  final usernameInputFinder = find.byKey(KeyValue.loginUsernameInput);
  final passwordInputFinder = find.byKey(KeyValue.loginPasswordInput);
  final buttonFinder = find.byKey(KeyValue.loginSignInBtn);

  await tester.enterText(usernameInputFinder, username);
  await tester.enterText(passwordInputFinder, password);
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pumpAndSettle();

  await tester.tap(buttonFinder);
  await tester.pumpAndSettle();

  expect(find.text(StringValue.searchInFakeStore), findsOneWidget);

  await Future.delayed(const Duration(seconds: 1));
}
