part of 'cart_viewmodel.dart';

enum CartStateType {
  initial,
  productAdded,
  productRemoved,
  productUpdated,
  created,
  error,
}

class CartState {
  const CartState({
    this.cart,
    this.error = '',
    this.type = CartStateType.initial,
  });

  final CartEntity? cart;
  final String error;
  final CartStateType type;

  CartState copyWith({
    CartEntity? cart,
    String? error,
    CartStateType? type,
  }) =>
      CartState(
        cart: cart ?? this.cart,
        error: error ?? this.error,
        type: type ?? this.type,
      );
}
