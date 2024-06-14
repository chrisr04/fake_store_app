import 'package:fake_api/fake_api.dart';

class FakeAuthRemoteDataSource {
  const FakeAuthRemoteDataSource(this._client);

  final FakeApiClient _client;

  Future<TokenEntity> logIn({
    required String username,
    required String password,
  }) =>
      _client.auth.logIn(username, password);

  Future<List<UserEntity>> getUsers() => _client.users.getUsers();

  Future<void> signUp(UserEntity user) => _client.users.createUser(user);
}
