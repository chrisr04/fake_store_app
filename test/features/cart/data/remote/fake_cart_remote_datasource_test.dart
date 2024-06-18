import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/features/cart/cart.dart';

import '../../../../mocks/fake_api_mocks.dart';

void main() {
  late FakeCartRemoteDataSource dataSource;
  late FakeApiClient client;
  late CartEntity cart;

  setUp(() {
    client = FakeApiClient();
    client.initMocks(
      MockAuthController(),
      MockProductController(),
      MockUserController(),
      MockCartController(),
    );
    dataSource = FakeCartRemoteDataSource(client);
    cart = CartEntity(
      id: 123,
      userId: 456,
      date: DateTime(2023, 6, 15),
      products: [],
    );

    when(() => client.carts.createCart(cart)).thenAnswer((_) async => cart);
  });

  group('FakeCartRemoteDataSource createCart', () {
    test(
      'should return a CartEntity when request is success',
      () async {
        final newCart = await dataSource.createCart(cart);

        expect(newCart, equals(cart));
      },
    );

    test(
      'should throws a FakeApiControllerException when request is failure',
      () async {
        when(() => client.carts.createCart(cart))
            .thenThrow(CartControllerException('Invalid carts'));

        expect(
          () => dataSource.createCart(cart),
          throwsA(isA<FakeApiControllerException>()),
        );
      },
    );
  });

  group('FakeCartRemoteDataSource addProduct', () {
    const cartProduct = CartProductEntity(
      productId: 1,
      quantity: 2,
      title: 'Product 1',
      price: 20.0,
      image: 'https://example.com/test_image.jpg',
    );

    test(
      'should return a CartEntity with a new product added',
      () async {
        await dataSource.createCart(cart);

        final newCart = dataSource.addProduct(cartProduct);

        expect(
          newCart.products.first.productId,
          equals(cartProduct.productId),
        );
      },
    );

    test(
      'should return an Error when the cart is not created',
      () async {
        expect(
          () => dataSource.addProduct(cartProduct),
          throwsA(isA<Error>()),
        );
      },
    );
  });

  group('FakeCartRemoteDataSource removeProduct', () {
    const cartProduct = CartProductEntity(
      productId: 1,
      quantity: 2,
      title: 'Product 1',
      price: 20.0,
      image: 'https://example.com/test_image.jpg',
    );

    test(
      'should return a CartEntity with a empty product list',
      () async {
        await dataSource.createCart(cart);

        dataSource.addProduct(cartProduct);

        final newCart = dataSource.removeProduct(cartProduct.productId);

        expect(newCart.products.isEmpty, isTrue);
      },
    );

    test(
      'should throws an Error when the cart is not created',
      () async {
        expect(
          () => dataSource.removeProduct(cartProduct.productId),
          throwsA(isA<Error>()),
        );
      },
    );
  });

  group('FakeCartRemoteDataSource updateProductQuantity', () {
    const cartProductOriginal = CartProductEntity(
      productId: 1,
      quantity: 2,
      title: 'Product 1',
      price: 20.0,
      image: 'https://example.com/test_image.jpg',
    );

    const cartProductChanged = CartProductEntity(
      productId: 1,
      quantity: 5,
      title: 'Product 1',
      price: 20.0,
      image: 'https://example.com/test_image.jpg',
    );

    test(
      'should return a CartEntity with a product quantity updated',
      () async {
        await dataSource.createCart(cart);

        dataSource.addProduct(cartProductOriginal);

        final newCart = dataSource.updateProductQuantity(cartProductChanged);

        expect(newCart.products.first.quantity, cartProductChanged.quantity);
      },
    );

    test(
      'should throws an Error when the cart is not created',
      () async {
        expect(
          () => dataSource.updateProductQuantity(cartProductOriginal),
          throwsA(isA<Error>()),
        );
      },
    );
  });
}
