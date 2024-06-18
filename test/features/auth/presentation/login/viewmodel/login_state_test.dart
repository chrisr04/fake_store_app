import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/features/auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginState', () {
    const oldUser = UserEntity(
      id: 1,
      name: UserNameEntity(
        firstname: 'Old',
        lastname: 'User',
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
        firstname: 'New',
        lastname: 'User',
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

    test('should have correct default values', () {
      final state = LoginState();

      expect(state.username, '');
      expect(state.password, '');
      expect(state.error, '');
      expect(state.type, LoginStateType.initial);
      expect(state.user, isNull);
    });

    test('copyWith updates only the specified values', () {
      final state = LoginState(
        username: 'old_username',
        password: 'old_password',
        error: 'old_error',
        type: LoginStateType.loading,
        user: oldUser,
      );

      final newState = state.copyWith(
        username: 'new_username',
        password: 'new_password',
        error: 'new_error',
        type: LoginStateType.loggedIn,
        user: newUser,
      );

      expect(newState.username, 'new_username');
      expect(newState.password, 'new_password');
      expect(newState.error, 'new_error');
      expect(newState.type, LoginStateType.loggedIn);
      expect(newState.user?.id, 2);
      expect(newState.user?.name.firstname, 'New');
    });

    test('copyWith should retain old values if not provided', () {
      final state = LoginState(
        username: 'old_username',
        password: 'old_password',
        error: 'old_error',
        type: LoginStateType.loading,
        user: oldUser,
      );

      final newState = state.copyWith();

      expect(newState.username, 'old_username');
      expect(newState.password, 'old_password');
      expect(newState.error, 'old_error');
      expect(newState.type, LoginStateType.loading);
      expect(newState.user?.id, 1);
      expect(newState.user?.name.firstname, 'Old');
    });
  });
}
