import 'package:fake_api/fake_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_app/features/cart/cart.dart';

void main() {
  group('CartState', () {
    final cart = CartEntity(
      id: 123,
      userId: 456,
      date: DateTime(2023, 6, 15),
      products: [],
    );

    test('should have correct default values', () {
      const cartState = CartState();

      expect(cartState.cart, isNull);
      expect(cartState.error, equals(''));
      expect(cartState.type, equals(CartStateType.initial));
    });

    test('copyWith should retain old values if not provided', () {
      const error = 'An error occurred';
      const type = CartStateType.productAdded;

      final cartState = CartState(
        cart: cart,
        error: error,
        type: type,
      );

      final copiedCartState = cartState.copyWith();

      expect(copiedCartState.cart, equals(cart));
      expect(copiedCartState.error, equals(error));
      expect(copiedCartState.type, equals(type));
    });

    test('copyWith updates only the specified values', () {
      const error = 'An error occurred';
      const type = CartStateType.productAdded;

      final cartState = CartState(
        cart: cart,
        error: error,
        type: type,
      );

      const newError = 'A new error occurred';
      const newType = CartStateType.productRemoved;

      final copiedCartState = cartState.copyWith(
        cart: cart,
        error: newError,
        type: newType,
      );

      expect(copiedCartState.cart, equals(cart));
      expect(copiedCartState.error, equals(newError));
      expect(copiedCartState.type, equals(newType));
    });
  });
}
