part of '../cart_page.dart';

class CartTitleRow extends StatelessWidget {
  const CartTitleRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: FakeSpacing.md,
        ).copyWith(
          top: FakeSpacing.xl,
          bottom: FakeSpacing.xs,
        ),
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
    );
  }
}
