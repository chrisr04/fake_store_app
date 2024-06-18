import 'package:dartz/dartz.dart';
import 'package:fake_api/fake_api.dart';

abstract class FakeCatalogRepository {
  Future<Either<Failure, List<ProductEntity>>> getCategoryProducts(
    String category,
  );
}
