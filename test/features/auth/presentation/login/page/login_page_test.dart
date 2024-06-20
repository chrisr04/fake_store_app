import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/features/auth/auth.dart';
import 'package:fake_store_app/navigation/navigation.dart';

class MockAppConfig extends Mock implements AppConfig {}

class MockFakeAuthRepository extends Mock implements FakeAuthRepository {}

class MockLoginViewModel extends LoginViewModel {
  MockLoginViewModel(super.repository);

  LoginState _fakeState = LoginState();

  @override
  LoginState get state => _fakeState;

  void changeStateAndNotify(LoginState newState) {
    _fakeState = newState;
    notifyListeners();
  }
}

void main() {
  group('LoginPage', () {
    late MockLoginViewModel loginViewModel;
    late MockFakeAuthRepository repository;
    late MockAppConfig appConfig;

    setUp(() {
      repository = MockFakeAuthRepository();
      loginViewModel = MockLoginViewModel(repository);
      appConfig = MockAppConfig();

      when(
        () => repository.logIn(
          password: any(named: 'password'),
          username: any(named: 'username'),
        ),
      ).thenAnswer((_) async => const Right(TokenEntity(token: '')));

      when(() => repository.getUsers())
          .thenAnswer((_) async => const Right([]));
    });

    Widget createWidget() => MultiProvider(
          providers: [
            ChangeNotifierProvider<LoginViewModel>.value(
              value: loginViewModel,
            ),
            Provider<AppConfig>.value(value: appConfig),
          ],
          child: MaterialApp(
            navigatorKey: FakeNavigator.rootNavigatorKey,
            home: const LoginPage(),
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => const Scaffold(
                body: Center(
                  child: Text('Home'),
                ),
              ),
            ),
          ),
        );

    testWidgets('should displays all required elements',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byType(LoginHeader), findsOneWidget);
      expect(find.byType(LoginForm), findsOneWidget);
    });

    testWidgets('should displays a loading modal when state type is loading',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidget());

      loginViewModel.changeStateAndNotify(
        LoginState(
          type: LoginStateType.loading,
        ),
      );
      await tester.pump();

      expect(find.text(StringValue.loggingIn), findsOneWidget);
    });

    testWidgets('should displays a error when state type is error',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidget());

      loginViewModel.changeStateAndNotify(
        LoginState(
          type: LoginStateType.loading,
        ),
      );
      await tester.pump();

      loginViewModel.changeStateAndNotify(
        LoginState(
          type: LoginStateType.error,
          error: 'Login error',
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Login error'), findsOneWidget);
    });

    testWidgets('should displays a not found error when state type is notFound',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidget());

      loginViewModel.changeStateAndNotify(
        LoginState(
          type: LoginStateType.loading,
        ),
      );
      await tester.pump();

      loginViewModel.changeStateAndNotify(
        LoginState(
          type: LoginStateType.notFound,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(StringValue.userNotFound), findsOneWidget);
    });

    testWidgets('should call to setLoggedUser and navigate to home page',
        (WidgetTester tester) async {
      const user = UserEntity(
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

      await tester.pumpWidget(createWidget());

      loginViewModel.changeStateAndNotify(
        LoginState(
          type: LoginStateType.loggedIn,
          user: user,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
      verify(() => appConfig.setLoggedUser(user)).called(1);
    });
  });
}
