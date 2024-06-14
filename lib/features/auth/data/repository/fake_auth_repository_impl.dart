import 'package:dartz/dartz.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/features/auth/data/remote/fake_auth_remote_datasource.dart';
import 'package:fake_store_app/features/auth/domain/repositories/fake_auth_repository.dart';

class FakeAuthRepositoryImpl extends FakeAuthRepository {
  FakeAuthRepositoryImpl(this._remoteDataSource);

  final FakeAuthRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    try {
      final users = await _remoteDataSource.getUsers();
      return Right(users);
    } catch (e) {
      return Left(RemoteFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TokenEntity>> logIn({
    required String username,
    required String password,
  }) async {
    try {
      final token = await _remoteDataSource.logIn(
        password: password,
        username: username,
      );
      return Right(token);
    } catch (e) {
      return Left(RemoteFailure(e.toString()));
    }
  }

  @override
  Future<Option<Failure>> signUp(UserEntity user) async {
    try {
      await _remoteDataSource.signUp(user);
      return const None();
    } catch (e) {
      return Some(RemoteFailure(e.toString()));
    }
  }
}
