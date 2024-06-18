import 'package:dartz/dartz.dart';
import 'package:fake_api/fake_api.dart';

abstract class FakeHomeRepository {
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();
}
