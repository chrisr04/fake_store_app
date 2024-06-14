import 'package:dartz/dartz.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/features/home/domain/domain.dart';
import 'package:fake_store_app/features/home/data/remote/fake_home_remote_datasource.dart';

class FakeHomeRepositoryImpl implements FakeHomeRepository {
  FakeHomeRepositoryImpl(this._remoteDataSource);

  final FakeHomeRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<ProductEntity>>> getMostBought() async {
    try {
      final products = await _remoteDataSource.getMostBought();
      return Right(products);
    } catch (e) {
      return Left(RemoteFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getPromotions() async {
    try {
      final products = await _remoteDataSource.getPromotions();
      return Right(products);
    } catch (e) {
      return Left(RemoteFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getRecentlyAdded() async {
    try {
      final products = await _remoteDataSource.getRecentlyAdded();
      return Right(products);
    } catch (e) {
      return Left(RemoteFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getRecommended() async {
    try {
      final products = await _remoteDataSource.getRecommended();
      return Right(products);
    } catch (e) {
      return Left(RemoteFailure(e.toString()));
    }
  }
}
