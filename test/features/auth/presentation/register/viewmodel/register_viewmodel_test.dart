import 'package:dartz/dartz.dart';
import 'package:fake_api/fake_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_app/features/auth/auth.dart';

import '../../../../../helpers/helpers.dart';

class MockFakeAuthRepository extends Mock implements FakeAuthRepository {}

void main() {
  late RegisterViewModel registerViewModel;
  late MockFakeAuthRepository repository;

  setUpAll(() {
    repository = MockFakeAuthRepository();
    registerViewModel = RegisterViewModel(repository);
  });

  group('RegisterViewModel', () {
    const password = '123';
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
      expect(registerViewModel.state.error, equals(''));
      expect(registerViewModel.state.password, equals(''));
      expect(registerViewModel.state.email, equals(''));
      expect(registerViewModel.state.phone, equals(''));
      expect(registerViewModel.state.name, equals(''));
      expect(registerViewModel.state.lastname, equals(''));
      expect(registerViewModel.state.user, isNull);
      expect(registerViewModel.state.username, equals(''));
      expect(registerViewModel.state.type, equals(RegisterStateType.initial));
    });

    test('onChangedField should change the name field correctly', () async {
      RegisterState firstState = RegisterState();

      final notifierCounter = await changeNotifierTest<RegisterViewModel>(
        notifier: registerViewModel,
        act: () => registerViewModel.onChangedField(
          field: RegisterFormField.name,
          value: user.name.firstname,
        ),
        onNotify: (notifierCounter) {
          firstState = registerViewModel.state;
        },
      );

      expect(firstState.name, equals(user.name.firstname));
      expect(firstState.type, equals(RegisterStateType.formChanged));
      expect(notifierCounter, equals(1));
    });

    test('onChangedField should change the lastname field correctly', () async {
      RegisterState firstState = RegisterState();

      final notifierCounter = await changeNotifierTest<RegisterViewModel>(
        notifier: registerViewModel,
        act: () => registerViewModel.onChangedField(
          field: RegisterFormField.lastname,
          value: user.name.lastname,
        ),
        onNotify: (notifierCounter) {
          firstState = registerViewModel.state;
        },
      );

      expect(firstState.lastname, equals(user.name.lastname));
      expect(firstState.type, equals(RegisterStateType.formChanged));
      expect(notifierCounter, equals(1));
    });

    test('onChangedField should change the email field correctly', () async {
      RegisterState firstState = RegisterState();

      final notifierCounter = await changeNotifierTest<RegisterViewModel>(
        notifier: registerViewModel,
        act: () => registerViewModel.onChangedField(
          field: RegisterFormField.email,
          value: user.email,
        ),
        onNotify: (notifierCounter) {
          firstState = registerViewModel.state;
        },
      );

      expect(firstState.email, equals(user.email));
      expect(firstState.type, equals(RegisterStateType.formChanged));
      expect(notifierCounter, equals(1));
    });

    test('onChangedField should change the phone field correctly', () async {
      RegisterState firstState = RegisterState();

      final notifierCounter = await changeNotifierTest<RegisterViewModel>(
        notifier: registerViewModel,
        act: () => registerViewModel.onChangedField(
          field: RegisterFormField.phone,
          value: user.phone,
        ),
        onNotify: (notifierCounter) {
          firstState = registerViewModel.state;
        },
      );

      expect(firstState.phone, equals(user.phone));
      expect(firstState.type, equals(RegisterStateType.formChanged));
      expect(notifierCounter, equals(1));
    });

    test('onChangedField should change the username field correctly', () async {
      RegisterState firstState = RegisterState();

      final notifierCounter = await changeNotifierTest<RegisterViewModel>(
        notifier: registerViewModel,
        act: () => registerViewModel.onChangedField(
          field: RegisterFormField.username,
          value: user.username,
        ),
        onNotify: (notifierCounter) {
          firstState = registerViewModel.state;
        },
      );

      expect(firstState.username, equals(user.username));
      expect(firstState.type, equals(RegisterStateType.formChanged));
      expect(notifierCounter, equals(1));
    });

    test('onChangedField should change the password field correctly', () async {
      RegisterState firstState = RegisterState();

      final notifierCounter = await changeNotifierTest<RegisterViewModel>(
        notifier: registerViewModel,
        act: () => registerViewModel.onChangedField(
          field: RegisterFormField.password,
          value: password,
        ),
        onNotify: (notifierCounter) {
          firstState = registerViewModel.state;
        },
      );

      expect(firstState.password, equals(password));
      expect(firstState.type, equals(RegisterStateType.formChanged));
      expect(notifierCounter, equals(1));
    });

    test(
        'onRegister should call signUp method and notify signedUp state type with a new UserEntity when request is success',
        () async {
      RegisterState firstState = RegisterState();
      RegisterState secondState = RegisterState();

      final notifierCounter = await changeNotifierTest<RegisterViewModel>(
        notifier: registerViewModel,
        setUp: () {
          when(
            () => repository.signUp(user),
          ).thenAnswer((_) async => const None());

          when(() => repository.getUsers())
              .thenAnswer((_) async => const Right([user]));
        },
        act: () => registerViewModel.onRegister(user),
        onNotify: (notifierCounter) {
          switch (notifierCounter) {
            case 1:
              firstState = registerViewModel.state;
              break;
            case 2:
              secondState = registerViewModel.state;
              break;
          }
        },
      );

      expect(firstState.type, equals(RegisterStateType.loading));
      expect(secondState.type, equals(RegisterStateType.signedUp));
      expect(secondState.user, equals(user));
      expect(notifierCounter, equals(2));
    });

    test(
        'onRegister should call logIn method and notify error state type with a new error message when request is failure',
        () async {
      RegisterState firstState = RegisterState();
      RegisterState secondState = RegisterState();

      final notifierCounter = await changeNotifierTest<RegisterViewModel>(
        notifier: registerViewModel,
        setUp: () {
          when(
            () => repository.signUp(user),
          ).thenAnswer(
            (_) async => const Some(RemoteFailure('Invalid credentials')),
          );
        },
        act: () => registerViewModel.onRegister(user),
        onNotify: (notifierCounter) {
          switch (notifierCounter) {
            case 1:
              firstState = registerViewModel.state;
              break;
            case 2:
              secondState = registerViewModel.state;
              break;
          }
        },
      );

      expect(firstState.type, equals(RegisterStateType.loading));
      expect(secondState.type, equals(RegisterStateType.error));
      expect(secondState.error, equals('Invalid credentials'));
      expect(notifierCounter, equals(2));
    });

    test(
        'onRegister should call logIn method and notify error state type with a new error message when getUsers is failure',
        () async {
      RegisterState firstState = RegisterState();
      RegisterState secondState = RegisterState();

      final notifierCounter = await changeNotifierTest<RegisterViewModel>(
        notifier: registerViewModel,
        setUp: () {
          when(
            () => repository.signUp(user),
          ).thenAnswer((_) async => const None());

          when(() => repository.getUsers()).thenAnswer(
            (_) async => const Left(RemoteFailure('Request error')),
          );
        },
        act: () => registerViewModel.onRegister(user),
        onNotify: (notifierCounter) {
          switch (notifierCounter) {
            case 1:
              firstState = registerViewModel.state;
              break;
            case 2:
              secondState = registerViewModel.state;
              break;
          }
        },
      );

      expect(firstState.type, equals(RegisterStateType.loading));
      expect(secondState.type, equals(RegisterStateType.error));
      expect(secondState.error, equals('Request error'));
      expect(notifierCounter, equals(2));
    });
  });
}
