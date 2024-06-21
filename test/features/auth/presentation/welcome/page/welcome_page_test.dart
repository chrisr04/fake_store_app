import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/navigation/navigation.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_app/features/auth/auth.dart';

void main() {
  setUpAll(() async {
    await AppConfig.init();
  });

  group('WelcomePage', () {
    testWidgets('widgets displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: WelcomePage(),
        ),
      );

      expect(find.byType(FakeImageAsset), findsOneWidget);
      expect(find.text(StringValue.welcome), findsOneWidget);
      expect(find.text(StringValue.weAreGladToHaveYouHere), findsOneWidget);
    });

    testWidgets('Navigate to logIn page', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: FakeNavigator.rootNavigatorKey,
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(
                child: Text('Sign In'),
              ),
            ),
          ),
          home: const WelcomePage(),
        ),
      );

      final logInButton = find.text(StringValue.signIn);
      expect(logInButton, findsOneWidget);
      await tester.tap(logInButton);
      await tester.pumpAndSettle();

      expect(find.text('Sign In'), findsOneWidget);
    });

    testWidgets('Navigate to register page', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: FakeNavigator.rootNavigatorKey,
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(
                child: Text('Sign Up'),
              ),
            ),
          ),
          home: const WelcomePage(),
        ),
      );

      final signUpButton = find.text(StringValue.signUp);
      expect(signUpButton, findsOneWidget);
      await tester.tap(signUpButton);
      await tester.pumpAndSettle();

      expect(find.text('Sign Up'), findsOneWidget);
    });
  });
}
