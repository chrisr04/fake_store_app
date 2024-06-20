import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'auth/login_test.dart';
import 'cart/add_to_cart_test.dart';
import 'cart/modify_product_cart_quantity_test.dart';
import 'cart/remove_from_cart_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final products = [
    'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
    'Mens Cotton Jacket',
    'Pierced Owl Rose Gold Plated Stainless Steel Double',
    'WD 4TB Gaming Drive Works with Playstation 4 Portable External Hard Drive',
    'Acer SB220Q bi 21.5 inches Full HD (1920 x 1080) IPS Ultra-Thin',
  ];

  testWidgets('Should add products to cart and modify it', (tester) async {
    await loginTest(
      tester,
      username: 'mor_2314',
      password: '83r5^_',
    );
    for (final product in products) {
      await addToCartTest(
        tester,
        productName: product,
      );
    }
    await modifyProductCartQuantityTest(
      tester,
      productName: products[0],
      quantity: 5,
    );
    await modifyProductCartQuantityTest(
      tester,
      productName: products[2],
      quantity: 8,
    );
    await removeFromCartTest(
      tester,
      productName: products.last,
    );
  });
}
