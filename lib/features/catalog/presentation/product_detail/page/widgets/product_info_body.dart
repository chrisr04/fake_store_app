part of '../product_detail_page.dart';

class ProductInfoBody extends StatelessWidget {
  const ProductInfoBody({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                child: FakeTextHeading4(
                  product.title,
                  weight: FontWeight.w500,
                ),
              ),
              const FakeSpacerS(axis: FakeSpacerAxis.x),
              FakeTextHeading4(
                '\$${product.price.toStringAsFixed(2).replaceAll('.', ',')}',
                weight: FontWeight.w700,
              ),
            ],
          ),
          FakeRatingStars(
            rating: product.rating.rate,
          ),
          const FakeSpacerS(),
          FakeTextMedium(
            product.description,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: FakeSpacing.lg,
              bottom: FakeSpacing.sm,
            ),
            child: FakeTextHeading5(StringValue.category),
          ),
          FakeChip(
            label: product.category,
          ),
        ],
      ),
    );
  }
}
