part of '../cart_page.dart';

class CartProductList extends StatelessWidget {
  const CartProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CartViewModel>();
    final products = viewModel.state.cart?.products ?? [];

    if (products.isEmpty) return const EmptyCartMessage();

    return SliverPadding(
      padding: const EdgeInsets.all(FakeSpacing.md),
      sliver: SliverList.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: FakeSpacing.sm,
            ),
            child: FakeShoppingCartCard(
              imageUrl: product.image,
              title: product.title,
              price: product.price,
              deleteButtonText: StringValue.delete,
              quantityValue: product.quantity.toString(),
              onDeleteButtonPressed: () {
                viewModel.onRemoveProduct(product.productId);
              },
              onQuantityChanged: (value) {
                final quantity = int.tryParse(value) ?? product.quantity;
                viewModel.onUpdateProductQuantity(
                  CartProductEntity(
                    quantity: quantity,
                    title: product.title,
                    image: product.image,
                    price: product.price,
                    productId: product.productId,
                  ),
                );
              },
              onAddButtonPressed: () {
                viewModel.onUpdateProductQuantity(
                  CartProductEntity(
                    quantity: product.quantity + 1,
                    title: product.title,
                    image: product.image,
                    price: product.price,
                    productId: product.productId,
                  ),
                );
              },
              onRemoveButtonPressed: () {
                if (product.quantity <= 1) return;
                viewModel.onUpdateProductQuantity(
                  CartProductEntity(
                    quantity: product.quantity - 1,
                    title: product.title,
                    image: product.image,
                    price: product.price,
                    productId: product.productId,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
