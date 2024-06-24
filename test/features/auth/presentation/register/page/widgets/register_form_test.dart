import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/features/auth/auth.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockRegisterViewModel extends Mock implements RegisterViewModel {}

void main() {
  late MockRegisterViewModel registerViewModel;
  late UserEntity user;

  setUpAll(() async {
    await AppConfig.initAssets();
    registerViewModel = MockRegisterViewModel();
    user = const UserEntity(
      id: 1,
      name: UserNameEntity(
        firstname: 'John',
        lastname: 'Doe',
      ),
      username: 'johndoe',
      email: 'john.doe@example.com',
      phone: '123-456-7890',
      address: AddressEntity(
        city: 'New York',
        street: '123 Main St',
        zipcode: '10001',
        number: 1,
        geolocation: GeolocationEntity(
          lat: '34.5464',
          long: '345.343',
        ),
      ),
    );
    registerFallbackValue(user);
  });

  group('RegisterForm', () {
    testWidgets('fill form data correctly', (WidgetTester tester) async {
      when(() => registerViewModel.state).thenReturn(RegisterState(user: user));
      when(() => registerViewModel.onRegister(any()))
          .thenAnswer((_) => Future<void>.value());

      await tester.pumpWidget(
        ChangeNotifierProvider<RegisterViewModel>.value(
          value: registerViewModel,
          child: const MaterialApp(
            home: Scaffold(
              body: RegisterForm(),
            ),
          ),
        ),
      );

      expect(find.text(StringValue.name), findsOneWidget);
      expect(find.text(StringValue.lastName), findsOneWidget);
      expect(find.text(StringValue.email), findsOneWidget);
      expect(find.text(StringValue.phone), findsOneWidget);
      expect(find.text(StringValue.user), findsOneWidget);
      expect(find.text(StringValue.password), findsOneWidget);
      expect(find.text(StringValue.signUp), findsOneWidget);

      final nameFinder = find.byWidgetPredicate(
        (widget) =>
            widget is FakeTextField &&
            widget.hintText == StringValue.writeYourName,
      );
      final lastNameFinder = find.byWidgetPredicate(
        (widget) =>
            widget is FakeTextField &&
            widget.hintText == StringValue.writeYourLastName,
      );
      final emailFinder = find.byWidgetPredicate(
        (widget) =>
            widget is FakeTextField &&
            widget.hintText == StringValue.writeYourEmail,
      );
      final phoneFinder = find.byWidgetPredicate(
        (widget) =>
            widget is FakeTextField &&
            widget.hintText == StringValue.writeYourPhone,
      );
      final userNameFinder = find.byWidgetPredicate(
        (widget) =>
            widget is FakeTextField &&
            widget.hintText == StringValue.writeYourUserName,
      );
      final passwordFinder = find.byWidgetPredicate(
        (widget) =>
            widget is FakeTextField &&
            widget.hintText == StringValue.writeYourPassword,
      );

      await tester.enterText(nameFinder, 'John');
      await tester.enterText(lastNameFinder, 'Doe');
      await tester.enterText(emailFinder, 'john.doe@example.com');
      await tester.enterText(phoneFinder, '1234567890');
      await tester.enterText(userNameFinder, 'john_doe');
      await tester.enterText(passwordFinder, 'password123');

      await tester.tap(find.text(StringValue.signUp));
      await tester.pump();

      expect(find.text('John'), findsOneWidget);
      expect(find.text('Doe'), findsOneWidget);
      expect(find.text('john.doe@example.com'), findsOneWidget);
      expect(find.text('1234567890'), findsOneWidget);
      expect(find.text('john_doe'), findsOneWidget);
      verify(() => registerViewModel.onRegister(any())).called(1);
    });

    testWidgets('fill form with incompleted data', (WidgetTester tester) async {
      when(() => registerViewModel.state).thenReturn(RegisterState(user: user));
      when(() => registerViewModel.onRegister(any()))
          .thenAnswer((_) => Future<void>.value());

      await tester.pumpWidget(
        ChangeNotifierProvider<RegisterViewModel>.value(
          value: registerViewModel,
          child: const MaterialApp(
            home: Scaffold(
              body: RegisterForm(),
            ),
          ),
        ),
      );

      expect(find.text(StringValue.name), findsOneWidget);
      expect(find.text(StringValue.lastName), findsOneWidget);
      expect(find.text(StringValue.email), findsOneWidget);
      expect(find.text(StringValue.phone), findsOneWidget);
      expect(find.text(StringValue.user), findsOneWidget);
      expect(find.text(StringValue.password), findsOneWidget);
      expect(find.text(StringValue.signUp), findsOneWidget);

      final nameFinder = find.byWidgetPredicate(
        (widget) =>
            widget is FakeTextField &&
            widget.hintText == StringValue.writeYourName,
      );
      final lastNameFinder = find.byWidgetPredicate(
        (widget) =>
            widget is FakeTextField &&
            widget.hintText == StringValue.writeYourLastName,
      );
      final emailFinder = find.byWidgetPredicate(
        (widget) =>
            widget is FakeTextField &&
            widget.hintText == StringValue.writeYourEmail,
      );
      final phoneFinder = find.byWidgetPredicate(
        (widget) =>
            widget is FakeTextField &&
            widget.hintText == StringValue.writeYourPhone,
      );
      final userNameFinder = find.byWidgetPredicate(
        (widget) =>
            widget is FakeTextField &&
            widget.hintText == StringValue.writeYourUserName,
      );

      await tester.enterText(nameFinder, 'John');
      await tester.enterText(lastNameFinder, 'Doe');
      await tester.enterText(emailFinder, 'john.doe@example.com');
      await tester.enterText(phoneFinder, '1234567890');
      await tester.enterText(userNameFinder, 'john_doe');

      await tester.tap(find.text(StringValue.signUp));
      await tester.pump();

      expect(find.text('John'), findsOneWidget);
      expect(find.text('Doe'), findsOneWidget);
      expect(find.text('john.doe@example.com'), findsOneWidget);
      expect(find.text('1234567890'), findsOneWidget);
      expect(find.text('john_doe'), findsOneWidget);
      verifyNever(() => registerViewModel.onRegister(any()));
    });
  });
}
