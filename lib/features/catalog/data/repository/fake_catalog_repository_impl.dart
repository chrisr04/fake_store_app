import 'package:dartz/dartz.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/features/catalog/domain/domain.dart';
import 'package:fake_store_app/features/catalog/data/remote/fake_catalog_remote_datasource.dart';

class FakeCatalogRepositoryImpl implements FakeCatalogRepository {
  const FakeCatalogRepositoryImpl(this._remoteDataSource);

  final FakeCatalogRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<ProductEntity>>> getCategoryProducts(
    String category,
  ) async {
    try {
      final products = await _remoteDataSource.getProductsByCategory(category);
      return Right(products);
    } catch (e) {
      return Left(RemoteFailure(e.toString()));
    }
  }
}
