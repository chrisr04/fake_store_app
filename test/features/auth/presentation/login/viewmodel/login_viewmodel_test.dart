import 'package:dartz/dartz.dart';
import 'package:fake_api/fake_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_app/features/auth/auth.dart';

import '../../../../../helpers/helpers.dart';

class MockFakeAuthRepository extends Mock implements FakeAuthRepository {}

void main() {
  late LoginViewModel loginViewModel;
  late MockFakeAuthRepository repository;

  setUpAll(() {
    repository = MockFakeAuthRepository();
    loginViewModel = LoginViewModel(repository);
  });

  group('LoginViewModel', () {
    const password = '123';
    const token = TokenEntity(token: '322633');
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

    test('should check initial state is correct', () {
      expect(loginViewModel.state.error, equals(''));
      expect(loginViewModel.state.password, equals(''));
      expect(loginViewModel.state.user, isNull);
      expect(loginViewModel.state.username, equals(''));
      expect(loginViewModel.state.type, equals(LoginStateType.initial));
    });

    test('onChangeUserName should change the username field correctly',
        () async {
      LoginState firstState = LoginState();

      final notifierCounter = await changeNotifierTest<LoginViewModel>(
        notifier: loginViewModel,
        act: () {
          loginViewModel.onChangeUserName('jhondoe');
        },
        onNotify: (notifierCounter) {
          firstState = loginViewModel.state;
        },
      );

      expect(firstState.username, equals('jhondoe'));
      expect(firstState.type, equals(LoginStateType.initial));
      expect(notifierCounter, equals(1));
    });

    test('onChangePassword should change the password field correctly',
        () async {
      LoginState firstState = LoginState();

      final notifierCounter = await changeNotifierTest<LoginViewModel>(
        notifier: loginViewModel,
        act: () {
          loginViewModel.onChangePassword('123');
        },
        onNotify: (notifierCounter) {
          firstState = loginViewModel.state;
        },
      );

      expect(firstState.password, equals('123'));
      expect(firstState.type, equals(LoginStateType.initial));
      expect(notifierCounter, equals(1));
    });

    test(
        'onLogIn should call logIn method and notify loggedIn state type with a new UserEntity when logIn is success',
        () async {
      LoginState firstState = LoginState();
      LoginState secondState = LoginState();

      final notifierCounter = await changeNotifierTest<LoginViewModel>(
        notifier: loginViewModel,
        setUp: () {
          when(
            () => repository.logIn(
              username: user.username,
              password: password,
            ),
          ).thenAnswer((_) async => const Right(token));

          when(() => repository.getUsers())
              .thenAnswer((_) async => const Right([user]));

          loginViewModel.onChangeUserName(user.username);
          loginViewModel.onChangePassword(password);
        },
        act: loginViewModel.onLogIn,
        onNotify: (notifierCounter) {
          switch (notifierCounter) {
            case 1:
              firstState = loginViewModel.state;
              break;
            case 2:
              secondState = loginViewModel.state;
              break;
          }
        },
      );

      expect(firstState.type, equals(LoginStateType.loading));
      expect(secondState.type, equals(LoginStateType.loggedIn));
      expect(secondState.user, equals(user));
      expect(notifierCounter, equals(2));
    });

    test(
        'onLogIn should call logIn method and notify a notFound state type when the user logged is not found',
        () async {
      LoginState firstState = LoginState();
      LoginState secondState = LoginState();

      final notifierCounter = await changeNotifierTest<LoginViewModel>(
        notifier: loginViewModel,
        setUp: () {
          const username = 'admin';
          when(
            () => repository.logIn(
              username: username,
              password: password,
            ),
          ).thenAnswer((_) async => const Right(token));

          when(() => repository.getUsers())
              .thenAnswer((_) async => const Right([user]));

          loginViewModel.onChangeUserName(username);
          loginViewModel.onChangePassword(password);
        },
        act: loginViewModel.onLogIn,
        onNotify: (notifierCounter) {
          switch (notifierCounter) {
            case 1:
              firstState = loginViewModel.state;
              break;
            case 2:
              secondState = loginViewModel.state;
              break;
          }
        },
      );

      expect(firstState.type, equals(LoginStateType.loading));
      expect(secondState.type, equals(LoginStateType.notFound));
      expect(notifierCounter, equals(2));
    });

    test(
        'onLogIn should call logIn method and notify error state type with a new error message when logIn is failure',
        () async {
      LoginState firstState = LoginState();
      LoginState secondState = LoginState();

      final notifierCounter = await changeNotifierTest<LoginViewModel>(
        notifier: loginViewModel,
        setUp: () {
          when(
            () => repository.logIn(
              username: user.username,
              password: password,
            ),
          ).thenAnswer(
            (_) async => const Left(RemoteFailure('Invalid credentials')),
          );

          loginViewModel.onChangeUserName(user.username);
          loginViewModel.onChangePassword(password);
        },
        act: loginViewModel.onLogIn,
        onNotify: (notifierCounter) {
          switch (notifierCounter) {
            case 1:
              firstState = loginViewModel.state;
              break;
            case 2:
              secondState = loginViewModel.state;
              break;
          }
        },
      );

      expect(firstState.type, equals(LoginStateType.loading));
      expect(secondState.type, equals(LoginStateType.error));
      expect(secondState.error, equals('Invalid credentials'));
      expect(notifierCounter, equals(2));
    });

    test(
        'onLogIn should call logIn method and notify error state type with a new error message when getUsers is failure',
        () async {
      LoginState firstState = LoginState();
      LoginState secondState = LoginState();

      final notifierCounter = await changeNotifierTest<LoginViewModel>(
        notifier: loginViewModel,
        setUp: () {
          when(
            () => repository.logIn(
              username: user.username,
              password: password,
            ),
          ).thenAnswer((_) async => const Right(token));

          when(() => repository.getUsers()).thenAnswer(
            (_) async => const Left(RemoteFailure('Request error')),
          );

          loginViewModel.onChangeUserName(user.username);
          loginViewModel.onChangePassword(password);
        },
        act: loginViewModel.onLogIn,
        onNotify: (notifierCounter) {
          switch (notifierCounter) {
            case 1:
              firstState = loginViewModel.state;
              break;
            case 2:
              secondState = loginViewModel.state;
              break;
          }
        },
      );

      expect(firstState.type, equals(LoginStateType.loading));
      expect(secondState.type, equals(LoginStateType.error));
      expect(secondState.error, equals('Request error'));
      expect(notifierCounter, equals(2));
    });
  });
}
