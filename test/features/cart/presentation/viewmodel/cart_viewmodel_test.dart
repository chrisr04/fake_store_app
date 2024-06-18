import 'package:dartz/dartz.dart';
import 'package:fake_api/fake_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_app/features/cart/cart.dart';

import '../../../../utils/utils.dart';

class MockFakeCartRepository extends Mock implements FakeCartRepository {}

void main() {
  late CartViewModel cartViewModel;
  late MockFakeCartRepository repository;

  setUpAll(() {
    repository = MockFakeCartRepository();
    cartViewModel = CartViewModel(repository);
  });

  group('CartViewModel', () {
    final emptyCart = CartEntity(
      id: 123,
      userId: 456,
      date: DateTime(2023, 6, 15),
      products: [],
    );

    const cartProduct = CartProductEntity(
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

    final filledCart = CartEntity(
      id: 456,
      userId: 456,
      date: DateTime(2023, 6, 15),
      products: const [cartProduct],
    );

    final changedCart = CartEntity(
      id: 456,
      userId: 456,
      date: DateTime(2023, 6, 15),
      products: const [cartProductChanged],
    );

    test('should check initial state is correct', () {
      expect(cartViewModel.state.cart, isNull);
      expect(cartViewModel.state.error, equals(''));
      expect(cartViewModel.state.type, equals(CartStateType.initial));
    });

    test(
        'isProductAdded should returns true when productId was found on the cart',
        () async {
      when(() => repository.createCart(filledCart))
          .thenAnswer((_) async => Right(filledCart));

      await cartViewModel.onCreateCart(filledCart);

      final isOnCart = cartViewModel.isProductAdded(cartProduct.productId);

      expect(isOnCart, isTrue);
    });

    test(
        'isProductAdded should returns false when productId was not found on the cart',
        () async {
      when(() => repository.createCart(filledCart))
          .thenAnswer((_) async => Right(filledCart));

      await cartViewModel.onCreateCart(filledCart);

      final isOnCart = cartViewModel.isProductAdded(1234);

      expect(isOnCart, isFalse);
    });

    test(
        'onCreateCart should call createCart method and notify a created state type when request is success',
        () async {
      CartState firstState = const CartState();

      final notifierCounter = await changeNotifierTest<CartViewModel>(
        notifier: cartViewModel,
        setUp: () {
          when(() => repository.createCart(emptyCart))
              .thenAnswer((_) async => Right(emptyCart));
        },
        act: () => cartViewModel.onCreateCart(emptyCart),
        onNotify: (notifierCounter) {
          firstState = cartViewModel.state;
        },
      );

      expect(firstState.type, equals(CartStateType.created));
      expect(firstState.cart, equals(emptyCart));
      expect(notifierCounter, equals(1));
    });

    test(
        'onCreateCart should call createCart method and notify a error state type when request is failure',
        () async {
      CartState firstState = const CartState();

      final notifierCounter = await changeNotifierTest<CartViewModel>(
        notifier: cartViewModel,
        setUp: () {
          when(() => repository.createCart(emptyCart)).thenAnswer(
            (_) async => const Left(RemoteFailure('Invalid request')),
          );
        },
        act: () => cartViewModel.onCreateCart(emptyCart),
        onNotify: (notifierCounter) {
          firstState = cartViewModel.state;
        },
      );

      expect(firstState.type, equals(CartStateType.error));
      expect(firstState.error, equals('Invalid request'));
      expect(notifierCounter, equals(1));
    });

    test(
        'onAddProduct should call addProduct method and notify a productAdded state type when request is success',
        () async {
      CartState firstState = const CartState();

      final notifierCounter = await changeNotifierTest<CartViewModel>(
        notifier: cartViewModel,
        setUp: () async {
          when(() => repository.addProduct(cartProduct))
              .thenAnswer((_) => Right(filledCart));

          when(() => repository.createCart(emptyCart))
              .thenAnswer((_) async => Right(emptyCart));

          await cartViewModel.onCreateCart(emptyCart);
        },
        act: () => cartViewModel.onAddProduct(cartProduct),
        onNotify: (notifierCounter) {
          firstState = cartViewModel.state;
        },
      );

      expect(firstState.type, equals(CartStateType.productAdded));
      expect(firstState.cart, equals(filledCart));
      expect(notifierCounter, equals(1));
    });

    test(
        'onAddProduct should call addProduct method and notify a error state type when request is failure',
        () async {
      CartState firstState = const CartState();

      final notifierCounter = await changeNotifierTest<CartViewModel>(
        notifier: cartViewModel,
        setUp: () async {
          when(() => repository.addProduct(cartProduct))
              .thenAnswer((_) => const Left(RemoteFailure('Invalid request')));

          when(() => repository.createCart(emptyCart))
              .thenAnswer((_) async => Right(emptyCart));

          await cartViewModel.onCreateCart(emptyCart);
        },
        act: () => cartViewModel.onAddProduct(cartProduct),
        onNotify: (notifierCounter) {
          firstState = cartViewModel.state;
        },
      );

      expect(firstState.type, equals(CartStateType.error));
      expect(firstState.error, equals('Invalid request'));
      expect(notifierCounter, equals(1));
    });

    test(
        'onRemoveProduct should call removeProduct method and notify a productRemoved state type when request is success',
        () async {
      CartState firstState = const CartState();

      final notifierCounter = await changeNotifierTest<CartViewModel>(
        notifier: cartViewModel,
        setUp: () async {
          when(() => repository.removeProduct(cartProduct.productId))
              .thenAnswer((_) => Right(emptyCart));

          when(() => repository.createCart(filledCart))
              .thenAnswer((_) async => Right(filledCart));

          await cartViewModel.onCreateCart(filledCart);
        },
        act: () => cartViewModel.onRemoveProduct(cartProduct.productId),
        onNotify: (notifierCounter) {
          firstState = cartViewModel.state;
        },
      );

      expect(firstState.type, equals(CartStateType.productRemoved));
      expect(firstState.cart, equals(emptyCart));
      expect(notifierCounter, equals(1));
    });

    test(
        'onRemoveProduct should call removeProduct method and notify a error state type when request is failure',
        () async {
      CartState firstState = const CartState();

      final notifierCounter = await changeNotifierTest<CartViewModel>(
        notifier: cartViewModel,
        setUp: () async {
          when(() => repository.removeProduct(cartProduct.productId))
              .thenAnswer((_) => const Left(RemoteFailure('Invalid request')));

          when(() => repository.createCart(filledCart))
              .thenAnswer((_) async => Right(filledCart));

          await cartViewModel.onCreateCart(filledCart);
        },
        act: () => cartViewModel.onRemoveProduct(cartProduct.productId),
        onNotify: (notifierCounter) {
          firstState = cartViewModel.state;
        },
      );

      expect(firstState.type, equals(CartStateType.error));
      expect(firstState.error, equals('Invalid request'));
      expect(notifierCounter, equals(1));
    });

    test(
        'onUpdateProductQuantity should call updateProductQuantity method and notify a productUpdated state type when request is success',
        () async {
      CartState firstState = const CartState();

      final notifierCounter = await changeNotifierTest<CartViewModel>(
        notifier: cartViewModel,
        setUp: () async {
          when(() => repository.updateProductQuantity(cartProductChanged))
              .thenAnswer((_) => Right(changedCart));

          when(() => repository.createCart(filledCart))
              .thenAnswer((_) async => Right(filledCart));

          await cartViewModel.onCreateCart(filledCart);
        },
        act: () => cartViewModel.onUpdateProductQuantity(cartProductChanged),
        onNotify: (notifierCounter) {
          firstState = cartViewModel.state;
        },
      );

      expect(firstState.type, equals(CartStateType.productUpdated));
      expect(firstState.cart, equals(changedCart));
      expect(notifierCounter, equals(1));
    });

    test(
        'onRemoveProduct should call updateProductQuantity method and notify a error state type when request is failure',
        () async {
      CartState firstState = const CartState();

      final notifierCounter = await changeNotifierTest<CartViewModel>(
        notifier: cartViewModel,
        setUp: () async {
          when(() => repository.updateProductQuantity(cartProductChanged))
              .thenAnswer((_) => const Left(RemoteFailure('Invalid request')));

          when(() => repository.createCart(filledCart))
              .thenAnswer((_) async => Right(filledCart));

          await cartViewModel.onCreateCart(filledCart);
        },
        act: () => cartViewModel.onUpdateProductQuantity(cartProductChanged),
        onNotify: (notifierCounter) {
          firstState = cartViewModel.state;
        },
      );

      expect(firstState.type, equals(CartStateType.error));
      expect(firstState.error, equals('Invalid request'));
      expect(notifierCounter, equals(1));
    });
  });
}
