import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/features/auth/auth.dart';

class MockFakeAuthRemoteDataSource extends Mock
    implements FakeAuthRemoteDataSource {}

void main() {
  late MockFakeAuthRemoteDataSource dataSource;
  late FakeAuthRepository repository;
  setUpAll(() {
    dataSource = MockFakeAuthRemoteDataSource();
    repository = FakeAuthRepositoryImpl(dataSource);
  });

  group('FakeAuthRepositoryImpl logIn', () {
    test(
      'should return a Right(TokenEntity) when request is success',
      () async {
        const username = 'jhondoe';
        const password = '12353';
        const token = TokenEntity(
          token: '1326',
        );

        when(() => dataSource.logIn(username: username, password: password))
            .thenAnswer((_) async => token);

        final result =
            await repository.logIn(username: username, password: password);

        expect(result, isA<Right>());
        expect((result as Right).value, isA<TokenEntity>());
      },
    );

    test(
      'should returns a Left(RemoteFailure) when request is failure',
      () async {
        const username = 'jhondoe';
        const password = '12353';

        when(() => dataSource.logIn(username: username, password: password))
            .thenThrow(AuthControllerException('Invalid credentials'));

        final result =
            await repository.logIn(username: username, password: password);

        expect(result, isA<Left>());
        expect((result as Left).value, isA<RemoteFailure>());
      },
    );
  });

  group('FakeAuthRepositoryImpl getUsers', () {
    test(
      'should return a Right(List<UserEntity>) when request is success',
      () async {
        when(() => dataSource.getUsers()).thenAnswer((_) async => []);

        final result = await repository.getUsers();

        expect(result, isA<Right>());
        expect((result as Right).value, isA<List<UserEntity>>());
      },
    );

    test(
      'should returns a Left(RemoteFailure) when request is failure',
      () async {
        when(() => dataSource.getUsers())
            .thenThrow(UserControllerException('Error'));

        final result = await repository.getUsers();

        expect(result, isA<Left>());
        expect((result as Left).value, isA<RemoteFailure>());
      },
    );
  });

  group('FakeAuthRepositoryImpl signUp', () {
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
      'should returns None when request is success',
      () async {
        when(() => dataSource.signUp(user)).thenAnswer((_) async => user);

        final result = await repository.signUp(user);

        expect(result, isA<None>());
      },
    );

    test(
      'should returns a Some(RemoteFailure) when request is failure',
      () async {
        when(() => dataSource.signUp(user))
            .thenThrow(UserControllerException('Invalid user data'));

        final result = await repository.signUp(user);

        expect(result, isA<Some>());
        expect((result as Some).value, isA<RemoteFailure>());
      },
    );
  });
}
