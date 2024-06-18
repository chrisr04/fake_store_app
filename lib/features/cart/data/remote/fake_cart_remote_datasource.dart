import 'package:fake_api/fake_api.dart';

class FakeCartRemoteDataSource {
  FakeCartRemoteDataSource(this._client);

  final FakeApiClient _client;
  late CartEntity _currentCart;

  Future<CartEntity> createCart(CartEntity cart) async {
    _currentCart = await _client.carts.createCart(cart);
    return _currentCart;
  }

  CartEntity addProduct(CartProductEntity cartProduct) {
    _currentCart.products.add(CartProductModel.fromDomain(cartProduct));
    return _currentCart;
  }

  CartEntity removeProduct(int productId) {
    _currentCart.products.removeWhere(
      (element) => element.productId == productId,
    );
    _currentCart = _currentCart;
    return _currentCart;
  }

  CartEntity updateProductQuantity(
    CartProductEntity cartProduct,
  ) {
    final index = _currentCart.products.indexWhere(
      (element) => element.productId == cartProduct.productId,
    );
    _currentCart.products[index] = CartProductModel.fromDomain(cartProduct);
    return _currentCart;
  }
}
