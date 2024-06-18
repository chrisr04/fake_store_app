import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/features/auth/auth.dart';

import '../../../../mocks/fake_api_mocks.dart';

void main() {
  late FakeAuthRemoteDataSource dataSource;
  late FakeApiClient client;
  setUpAll(() {
    client = FakeApiClient();
    client.initMocks(
      MockAuthController(),
      MockProductController(),
      MockUserController(),
      MockCartController(),
    );
    dataSource = FakeAuthRemoteDataSource(client);
  });

  group('FakeAuthRemoteDataSource logIn', () {
    test(
      'should return a TokenEntity when request is success',
      () async {
        const username = 'jhondoe';
        const password = '12353';
        const token = TokenEntity(
          token: '1326',
        );

        when(() => client.auth.logIn(username, password))
            .thenAnswer((_) async => token);

        final response =
            await dataSource.logIn(username: username, password: password);

        expect(response, equals(token));
      },
    );

    test(
      'should throws a FakeApiControllerException when request is failure',
      () async {
        const username = 'jhondoe';
        const password = '12353';

        when(() => client.auth.logIn(username, password))
            .thenThrow(AuthControllerException('Invalid credentials'));

        expect(
          () => dataSource.logIn(username: username, password: password),
          throwsA(isA<FakeApiControllerException>()),
        );
      },
    );
  });

  group('FakeAuthRemoteDataSource getUsers', () {
    test(
      'should return a List<UserEntity> when request is success',
      () async {
        when(() => client.users.getUsers()).thenAnswer((_) async => []);

        final response = await dataSource.getUsers();

        expect(response, isA<List<UserEntity>>());
      },
    );

    test(
      'should throws a FakeApiControllerException when request is failure',
      () async {
        when(() => client.users.getUsers())
            .thenThrow(UserControllerException('Error'));

        expect(
          () => dataSource.getUsers(),
          throwsA(isA<FakeApiControllerException>()),
        );
      },
    );
  });

  group('FakeAuthRemoteDataSource signUp', () {
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

    test(
      'should call createUser method only one time',
      () async {
        when(() => client.users.createUser(user)).thenAnswer((_) async => user);

        await dataSource.signUp(user);

        verify(() => client.users.createUser(user)).called(1);
      },
    );

    test(
      'should throws a FakeApiControllerException when request is failure',
      () async {
        when(() => client.users.createUser(user))
            .thenThrow(UserControllerException('Invalid user data'));

        expect(
          () => dataSource.signUp(user),
          throwsA(isA<FakeApiControllerException>()),
        );
      },
    );
  });
}
