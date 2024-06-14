import 'package:dartz/dartz.dart';
import 'package:fake_api/fake_api.dart';

abstract class FakeAuthRepository {
  Future<Either<Failure, TokenEntity>> logIn({
    required String username,
    required String password,
  });

  Future<Either<Failure, List<UserEntity>>> getUsers();

  Future<Option<Failure>> signUp(UserEntity user);
}
