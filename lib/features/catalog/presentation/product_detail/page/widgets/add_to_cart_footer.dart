part of '../product_detail_page.dart';

class AddToCartFooter extends StatelessWidget {
  const AddToCartFooter({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final cartViewModel = context.watch<CartViewModel>();
    final isOnCart = cartViewModel.isProductAdded(product.id);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadowVariant,
            offset: const Offset(0.0, -5.0),
            blurRadius: 16.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(FakeSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Semantics(
              sortKey: const OrdinalSortKey(double.maxFinite),
              child: SizedBox(
                width: double.infinity,
                child: FakeButtonPrimary(
                  onPressed: () {
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
                  label: isOnCart
                      ? StringValue.removeFromCart
                      : StringValue.addToCart,
                  size: FakeButtonSize.large,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
