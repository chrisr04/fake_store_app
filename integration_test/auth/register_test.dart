import 'package:fake_store_app/common/common.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:fake_store_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Should fill the form fields and Sign Up', registerTest);
}

Future<void> registerTest(WidgetTester tester) async {
  app.main();

  await tester.pumpAndSettle();

  expect(find.text(StringValue.welcome), findsOneWidget);

  await tester.tap(find.byKey(KeyValue.welcomeSignUpBtn));
  await tester.pumpAndSettle();

  final nameInputFinder = find.byKey(KeyValue.registerNameInput);
  final lastNameInputFinder = find.byKey(KeyValue.registerLastNameInput);
  final emailInputFinder = find.byKey(KeyValue.registerEmailInput);
  final phoneInputFinder = find.byKey(KeyValue.registerPhoneInput);
  final usernameInputFinder = find.byKey(KeyValue.registerUsernameInput);
  final passwordInputFinder = find.byKey(KeyValue.registerPasswordInput);
  final buttonFinder = find.byKey(KeyValue.registerSignUpBtn);

  await tester.enterText(nameInputFinder, 'Jhon');
  await tester.enterText(lastNameInputFinder, 'Doe');
  await tester.enterText(emailInputFinder, 'jhondoe@example.com');
  await tester.enterText(phoneInputFinder, '343-679-56566');
  await tester.enterText(usernameInputFinder, 'jhon_doe');
  await tester.enterText(passwordInputFinder, 'admin123');

  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pumpAndSettle();

  await tester.tap(buttonFinder);
  await tester.pumpAndSettle();

  await tester.tap(find.text(StringValue.continueText));
  await tester.pumpAndSettle();

  expect(find.text(StringValue.searchInFakeStore), findsOneWidget);

  await Future.delayed(const Duration(seconds: 1));
}
