import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/navigation/navigation.dart';
import 'package:fake_store_app/features/cart/cart.dart';

class VerticalProductSliverList extends StatelessWidget {
  const VerticalProductSliverList({
    super.key,
    required this.products,
  });

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    final cartViewModel = context.watch<CartViewModel>();
    return SliverPadding(
      padding: const EdgeInsets.all(FakeSpacing.md),
      sliver: SliverList.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final isOnCart = cartViewModel.isProductAdded(product.id);
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: FakeSpacing.sm,
            ),
            child: FakeHorizontalProductCard(
              onTap: () => FakeNavigator.menu.pushNamed(
                AppRoutes.productDetail,
                arguments: product,
              ),
              onFilledButtonPressed: () {
                if (isOnCart) {
                  cartViewModel.onRemoveProduct(product.id);
                  return;
                }
                cartViewModel.onAddProduct(
                  CartProductEntity(
                    productId: product.id,
                    quantity: 1,
                    title: product.title,
                    price: product.price,
                    image: product.image,
                  ),
                );
              },
              onOutlinedButtonPressed: () {},
              imageUrl: product.image,
              title: product.title,
              description: product.description,
              price: product.price,
              filledButtonText:
                  isOnCart ? StringValue.removeFromCart : StringValue.addToCart,
              outlinedButtonText: StringValue.buy,
            ),
          );
        },
      ),
    );
  }
}
