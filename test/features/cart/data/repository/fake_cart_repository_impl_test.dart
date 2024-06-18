import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/features/cart/cart.dart';

class MockFakeCartRemoteDataSource extends Mock
    implements FakeCartRemoteDataSource {}

void main() {
  late MockFakeCartRemoteDataSource dataSource;
  late FakeCartRepository repository;
  late CartEntity cart;

  setUp(() {
    dataSource = MockFakeCartRemoteDataSource();
    repository = FakeCartRepositoryImpl(dataSource);
    cart = CartEntity(
      id: 123,
      userId: 456,
      date: DateTime(2023, 6, 15),
      products: [],
    );
  });

  group('FakeCartRepositoryImpl createCart', () {
    test(
      'should return a Right(CartEntity) when request is success',
      () async {
        when(() => dataSource.createCart(cart)).thenAnswer((_) async => cart);
        final result = await repository.createCart(cart);

        expect(result, isA<Right>());
        expect((result as Right).value, isA<CartEntity>());
      },
    );

    test(
      'should throws a Left(RemoteFailure) when request is failure',
      () async {
        when(() => dataSource.createCart(cart))
            .thenThrow(CartControllerException('Invalid carts'));

        final result = await repository.createCart(cart);

        expect(result, isA<Left>());
        expect((result as Left).value, isA<RemoteFailure>());
      },
    );
  });

  group('FakeCartRepositoryImpl addProduct', () {
    const cartProduct = CartProductEntity(
      productId: 1,
      quantity: 2,
      title: 'Product 1',
      price: 20.0,
      image: 'https://example.com/test_image.jpg',
    );

    setUp(() {
      cart.products.add(cartProduct);
    });

    test(
      'should return a Right(CartEntity) with a new product added',
      () {
        when(() => dataSource.addProduct(cartProduct)).thenAnswer((_) => cart);

        final result = repository.addProduct(cartProduct);

        expect(result, isA<Right>());
        expect((result as Right).value, isA<CartEntity>());
      },
    );

    test(
      'should throws a Left(RemoteFailure) when request is failure',
      () {
        when(() => dataSource.addProduct(cartProduct)).thenThrow(Error());

        final result = repository.addProduct(cartProduct);

        expect(result, isA<Left>());
        expect((result as Left).value, isA<RemoteFailure>());
      },
    );
  });

  group('FakeCartRepositoryImpl removeProduct', () {
    const cartProduct = CartProductEntity(
      productId: 1,
      quantity: 2,
      title: 'Product 1',
      price: 20.0,
      image: 'https://example.com/test_image.jpg',
    );

    test(
      'should return a Right(CartEntity) with a new product added',
      () async {
        when(() => dataSource.removeProduct(cartProduct.productId))
            .thenAnswer((_) => cart);

        final result = repository.removeProduct(cartProduct.productId);

        expect(result, isA<Right>());
        expect((result as Right).value, isA<CartEntity>());
      },
    );

    test(
      'should throws a Left(RemoteFailure) when request is failure',
      () {
        when(() => dataSource.removeProduct(cartProduct.productId))
            .thenThrow(Error());

        final result = repository.removeProduct(cartProduct.productId);

        expect(result, isA<Left>());
        expect((result as Left).value, isA<RemoteFailure>());
      },
    );
  });

  group('FakeCartRepositoryImpl updateProductQuantity', () {
    const cartProduct = CartProductEntity(
      productId: 1,
      quantity: 2,
      title: 'Product 1',
      price: 20.0,
      image: 'https://example.com/test_image.jpg',
    );

    test(
      'should return a Right(CartEntity) with a product quantity updated',
      () async {
        when(() => dataSource.updateProductQuantity(cartProduct))
            .thenAnswer((_) => cart);

        final result = repository.updateProductQuantity(cartProduct);

        expect(result, isA<Right>());
        expect((result as Right).value, isA<CartEntity>());
      },
    );

    test(
      'should throws a Left(RemoteFailure) when request is failure',
      () {
        when(() => dataSource.updateProductQuantity(cartProduct))
            .thenThrow(Error());

        final result = repository.updateProductQuantity(cartProduct);

        expect(result, isA<Left>());
        expect((result as Left).value, isA<RemoteFailure>());
      },
    );
  });
}
