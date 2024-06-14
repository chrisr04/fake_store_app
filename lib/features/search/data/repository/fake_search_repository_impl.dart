import 'package:dartz/dartz.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/features/search/domain/domain.dart';
import 'package:fake_store_app/features/search/data/remote/fake_search_remote_datasource.dart';

class FakeSearchRepositoryImpl implements FakeSearchRepository {
  const FakeSearchRepositoryImpl(this._remoteDataSource);

  final FakeSearchRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProducts(
    String query,
  ) async {
    try {
      final products = await _remoteDataSource.searchProducts(query);

      return Right(products);
    } catch (e) {
      return Left(RemoteFailure(e.toString()));
    }
  }
}
