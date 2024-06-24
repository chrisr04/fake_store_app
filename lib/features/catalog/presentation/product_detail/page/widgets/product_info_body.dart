part of '../product_detail_page.dart';

class ProductInfoBody extends StatelessWidget {
  const ProductInfoBody({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final semantics = context.watch<ProductDetailSemantics>();
    return MergeSemantics(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: FakeSpacing.md,
          vertical: FakeSpacing.lg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Semantics(
                    label: semantics.productTitle.label,
                    sortKey: OrdinalSortKey(semantics.productTitle.order),
                    child: FakeTextHeading4(
                      product.title,
                      weight: FontWeight.w500,
                    ),
                  ),
                ),
                const FakeSpacerS(axis: FakeSpacerAxis.x),
                Semantics(
                  label: semantics.productPrice.label,
                  sortKey: OrdinalSortKey(semantics.productPrice.order),
                  child: FakeTextHeading4(
                    '\$${product.price.toStringAsFixed(2).replaceAll('.', ',')}',
                    weight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            FakeRatingStars(
              rating: product.rating.rate,
            ),
            const FakeSpacerS(),
            Semantics(
              label: semantics.productDescription.label,
              sortKey: OrdinalSortKey(semantics.productDescription.order),
              child: FakeTextMedium(
                product.description,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            ExcludeSemantics(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: FakeSpacing.lg,
                  bottom: FakeSpacing.sm,
                ),
                child: FakeTextHeading5(StringValue.category),
              ),
            ),
            Semantics(
              label: semantics.productCategory.label,
              sortKey: OrdinalSortKey(semantics.productCategory.order),
              child: FakeChip(
                label: product.category,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
