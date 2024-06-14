import 'package:dartz/dartz.dart';
import 'package:fake_api/fake_api.dart';

abstract class FakeSearchRepository {
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String query);
}
