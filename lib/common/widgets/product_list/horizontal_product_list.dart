import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/features/cart/cart.dart';
import 'package:fake_store_app/navigation/navigation.dart';

class HorizontalProductList extends StatelessWidget {
  const HorizontalProductList({
    super.key,
    required this.title,
    required this.products,
    this.semanticTitle = '',
    this.semanticsSortKey,
  });

  final String title;
  final List<ProductEntity> products;
  final String semanticTitle;
  final SemanticsSortKey? semanticsSortKey;

  @override
  Widget build(BuildContext context) {
    final cartViewModel = context.watch<CartViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: FakeSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            label: semanticTitle,
            excludeSemantics: semanticTitle.isNotEmpty,
            sortKey: semanticsSortKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: FakeSpacing.md,
              ).copyWith(
                bottom: FakeSpacing.sl,
              ),
              child: FakeTextHeading6(title),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 320.0,
            child: ListView.builder(
              itemCount: products.length,
              padding: const EdgeInsets.symmetric(
                horizontal: FakeSpacing.sm,
              ),
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final product = products[index];
                final isOnCart = cartViewModel.isProductAdded(product.id);
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: FakeSpacing.sm,
                  ),
                  child: FakeProductCard(
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
                    filledButtonText: isOnCart
                        ? StringValue.removeFromCart
                        : StringValue.addToCart,
                    outlinedButtonText: StringValue.buy,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
