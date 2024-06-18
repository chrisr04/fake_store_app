import 'package:fake_api/fake_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_app/features/auth/auth.dart';

void main() {
  group('RegisterState', () {
    const oldUser = UserEntity(
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

    const newUser = UserEntity(
      id: 2,
      name: UserNameEntity(
        firstname: 'Jane',
        lastname: 'Smith',
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

    test('initial state has default values', () {
      final state = RegisterState();

      expect(state.name, '');
      expect(state.lastname, '');
      expect(state.email, '');
      expect(state.phone, '');
      expect(state.username, '');
      expect(state.password, '');
      expect(state.error, '');
      expect(state.type, RegisterStateType.initial);
      expect(state.user, isNull);
    });

    test('copyWith creates a new state with updated values', () {
      final state = RegisterState(
        name: 'John',
        lastname: 'Doe',
        email: 'john.doe@example.com',
        phone: '1234567890',
        username: 'johndoe',
        password: 'password123',
        error: 'Error message',
        type: RegisterStateType.error,
        user: oldUser,
      );

      final newState = state.copyWith(
        name: 'Jane',
        lastname: 'Smith',
        email: 'jane.smith@example.com',
        phone: '0987654321',
        username: 'janesmith',
        password: 'newpassword',
        error: '',
        type: RegisterStateType.signedUp,
        user: newUser,
      );

      expect(newState.name, 'Jane');
      expect(newState.lastname, 'Smith');
      expect(newState.email, 'jane.smith@example.com');
      expect(newState.phone, '0987654321');
      expect(newState.username, 'janesmith');
      expect(newState.password, 'newpassword');
      expect(newState.error, '');
      expect(newState.type, RegisterStateType.signedUp);
      expect(newState.user, isNotNull);
      expect(newState.user!.id, 2);
    });

    test('copyWith retains old values when new ones are null', () {
      final state = RegisterState(
        name: 'John',
        lastname: 'Doe',
        email: 'john.doe@example.com',
        phone: '1234567890',
        username: 'johndoe',
        password: 'password123',
        error: 'Error message',
        type: RegisterStateType.error,
        user: oldUser,
      );

      final newState = state.copyWith();

      expect(newState.name, 'John');
      expect(newState.lastname, 'Doe');
      expect(newState.email, 'john.doe@example.com');
      expect(newState.phone, '1234567890');
      expect(newState.username, 'johndoe');
      expect(newState.password, 'password123');
      expect(newState.error, 'Error message');
      expect(newState.type, RegisterStateType.error);
      expect(newState.user, isNotNull);
      expect(newState.user!.id, 1);
    });
  });
}
