import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/features/auth/auth.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockLoginViewModel extends Mock implements LoginViewModel {}

void main() {
  late MockLoginViewModel loginViewModel;
  setUpAll(() async {
    await AppConfig.initAssets();
    loginViewModel = MockLoginViewModel();
  });

  group('LoginForm', () {
    testWidgets('fill form data correctly', (WidgetTester tester) async {
      when(() => loginViewModel.onLogIn())
          .thenAnswer((_) => Future<void>.value());

      await tester.pumpWidget(
        ChangeNotifierProvider<LoginViewModel>(
          create: (context) => loginViewModel,
          child: const MaterialApp(
            home: Scaffold(
              body: LoginForm(),
            ),
          ),
        ),
      );

      expect(find.text(StringValue.user), findsOneWidget);
      expect(find.text(StringValue.writeYourUserName), findsOneWidget);
      expect(find.text(StringValue.password), findsOneWidget);
      expect(find.text(StringValue.writeYourPassword), findsOneWidget);
      expect(find.text(StringValue.signIn), findsOneWidget);

      await tester.enterText(find.byType(FakeTextField).first, 'test_user');
      await tester.enterText(
        find.byType(FakeTextFieldObscure).first,
        'test_password',
      );

      await tester.tap(find.byType(FakeButtonPrimary));
      await tester.pump();

      expect(find.text('test_user'), findsOneWidget);
      expect(find.text('test_password'), findsOneWidget);
      verify(() => loginViewModel.onLogIn()).called(1);
    });

    testWidgets('fill form with incompleted data', (WidgetTester tester) async {
      when(() => loginViewModel.onLogIn())
          .thenAnswer((_) => Future<void>.value());

      await tester.pumpWidget(
        ChangeNotifierProvider<LoginViewModel>(
          create: (context) => loginViewModel,
          child: const MaterialApp(
            home: Scaffold(
              body: LoginForm(),
            ),
          ),
        ),
      );

      expect(find.text(StringValue.user), findsOneWidget);
      expect(find.text(StringValue.writeYourUserName), findsOneWidget);
      expect(find.text(StringValue.password), findsOneWidget);
      expect(find.text(StringValue.writeYourPassword), findsOneWidget);
      expect(find.text(StringValue.signIn), findsOneWidget);

      await tester.enterText(find.byType(FakeTextField).first, 'test_user');

      await tester.tap(find.byType(FakeButtonPrimary));
      await tester.pump();

      expect(find.text('test_user'), findsOneWidget);
      verifyNever(() => loginViewModel.onLogIn());
    });
  });
}
