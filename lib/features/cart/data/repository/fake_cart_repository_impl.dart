import 'package:dartz/dartz.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/features/cart/domain/domain.dart';
import 'package:fake_store_app/features/cart/data/remote/fake_cart_remote_datasource.dart';

class FakeCartRepositoryImpl implements FakeCartRepository {
  const FakeCartRepositoryImpl(this._remoteDataSource);

  final FakeCartRemoteDataSource _remoteDataSource;

  @override
  Either<Failure, CartEntity> addProduct(
    CartProductEntity cartProduct,
  ) {
    try {
      final cart = _remoteDataSource.addProduct(cartProduct);
      return Right(cart);
    } catch (e) {
      return Left(RemoteFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> createCart(CartEntity cart) async {
    try {
      final createdCart = await _remoteDataSource.createCart(cart);
      return Right(createdCart);
    } catch (e) {
      return Left(RemoteFailure(e.toString()));
    }
  }

  @override
  Either<Failure, CartEntity> removeProduct(int productId) {
    try {
      final cart = _remoteDataSource.removeProduct(productId);
      return Right(cart);
    } catch (e) {
      return Left(RemoteFailure(e.toString()));
    }
  }

  @override
  Either<Failure, CartEntity> updateProductQuantity(
    CartProductEntity cartProduct,
  ) {
    try {
      final cart = _remoteDataSource.updateProductQuantity(cartProduct);
      return Right(cart);
    } catch (e) {
      return Left(RemoteFailure(e.toString()));
    }
  }
}
