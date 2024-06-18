import 'package:dartz/dartz.dart';
import 'package:fake_api/fake_api.dart';

abstract class FakeCartRepository {
  Future<Either<Failure, CartEntity>> createCart(CartEntity cart);
  Either<Failure, CartEntity> addProduct(CartProductEntity cartProduct);
  Either<Failure, CartEntity> removeProduct(int productId);
  Either<Failure, CartEntity> updateProductQuantity(
    CartProductEntity cartProduct,
  );
}
