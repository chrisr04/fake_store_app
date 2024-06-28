part of '../cart_page.dart';

class TotalCartFooter extends StatelessWidget {
  const TotalCartFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final semantics = context.watch<CartSemantics>();
    final state = context.watch<CartViewModel>().state;
    final products = state.cart?.products ?? [];
    final total = _getTotal(products);
    if (products.isEmpty) return const SizedBox.shrink();
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
        padding: const EdgeInsets.all(FakeSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MergeSemantics(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Semantics(
                    label: semantics.totalResume.label,
                    excludeSemantics: true,
                    child: FakeTextHeading6(StringValue.total),
                  ),
                  Flexible(
                    child: FakeTextHeading5(
                      '\$${total.toStringAsFixed(2).replaceAll('.', ',')}',
                    ),
                  ),
                ],
              ),
            ),
            const FakeSpacerM(),
            SizedBox(
              width: double.infinity,
              child: FakeButtonPrimary(
                onPressed: () {},
                label: StringValue.checkout,
                size: FakeButtonSize.large,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getTotal(List<CartProductEntity> products) {
    return products.fold(
      0.0,
      (value, product) => value + (product.quantity * product.price),
    );
  }
}
