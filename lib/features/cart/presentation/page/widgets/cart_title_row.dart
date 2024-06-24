part of '../cart_page.dart';

class CartTitleRow extends StatelessWidget {
  const CartTitleRow({super.key});

  @override
  Widget build(BuildContext context) {
    final semantics = context.watch<CartSemantics>();
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: FakeSpacing.md,
        ).copyWith(
          top: FakeSpacing.xl,
          bottom: FakeSpacing.xs,
        ),
        child: Semantics(
          label: semantics.cartTitle.label,
          sortKey: OrdinalSortKey(semantics.cartTitle.order),
          excludeSemantics: true,
          focused: true,
          child: Row(
            children: [
              const FakeIcon(
                Icons.shopping_cart_outlined,
                size: 32.0,
              ),
              const FakeSpacerS(axis: FakeSpacerAxis.x),
              Flexible(
                child: FakeTextHeading3(
                  StringValue.myCart,
                  weight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
