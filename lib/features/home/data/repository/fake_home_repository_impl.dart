import 'package:dartz/dartz.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/features/home/domain/domain.dart';
import 'package:fake_store_app/features/home/data/remote/fake_home_remote_datasource.dart';

class FakeHomeRepositoryImpl implements FakeHomeRepository {
  FakeHomeRepositoryImpl(this._remoteDataSource);

  final FakeHomeRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    try {
      final products = await _remoteDataSource.getAllProducts();
      return Right(products);
    } catch (e) {
      return Left(RemoteFailure(e.toString()));
    }
  }
}
