import 'package:flutter/material.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/features/cart/domain/domain.dart';

part 'cart_state.dart';

class CartViewModel with ChangeNotifier {
  CartViewModel(this._repository);

  final FakeCartRepository _repository;
  CartState state = const CartState();

  bool isProductAdded(int productId) {
    final isAdded = state.cart?.products.any(
      (product) => product.productId == productId,
    );
    return isAdded ?? false;
  }

  void onCreateCart(CartEntity cart) async {
    final failureOrCreated = await _repository.createCart(cart);
    failureOrCreated.fold(
      (failure) {
        state = state.copyWith(
          error: failure.message,
          type: CartStateType.error,
        );
      },
      (cart) {
        state = state.copyWith(
          cart: cart,
          type: CartStateType.created,
        );
      },
    );
    notifyListeners();
  }

  void onAddProduct(CartProductEntity cartProduct) {
    if (state.cart == null) return;

    final failureOrAdded = _repository.addProduct(cartProduct);

    failureOrAdded.fold(
      (failure) {
        state = state.copyWith(
          error: failure.message,
          type: CartStateType.error,
        );
      },
      (cart) {
        state = state.copyWith(
          cart: cart,
          type: CartStateType.productAdded,
        );
      },
    );
    notifyListeners();
  }

  void onRemoveProduct(int productId) {
    if (state.cart == null) return;

    final failureOrRemoved = _repository.removeProduct(productId);

    failureOrRemoved.fold(
      (failure) {
        state = state.copyWith(
          error: failure.message,
          type: CartStateType.error,
        );
      },
      (cart) {
        state = state.copyWith(
          cart: cart,
          type: CartStateType.productRemoved,
        );
      },
    );
    notifyListeners();
  }

  void onUpdateProductQuantity(CartProductEntity cartProduct) {
    if (state.cart == null) return;

    final failureOrUpdated = _repository.updateProductQuantity(cartProduct);

    failureOrUpdated.fold(
      (failure) {
        state = state.copyWith(
          error: failure.message,
          type: CartStateType.error,
        );
      },
      (cart) {
        state = state.copyWith(
          cart: cart,
          type: CartStateType.productUpdated,
        );
      },
    );
    notifyListeners();
  }
}
