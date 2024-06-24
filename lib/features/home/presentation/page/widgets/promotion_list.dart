part of '../home_page.dart';

class PromotionList extends StatelessWidget {
  const PromotionList({super.key, required this.promotions});

  final List<ProductEntity> promotions;

  @override
  Widget build(BuildContext context) {
    final semantics = context.watch<HomeSemantics>();
    return HorizontalProductList(
      title: StringValue.promotions,
      semanticTitle: semantics.promotionSubtitle.label,
      semanticsSortKey: OrdinalSortKey(semantics.promotionSubtitle.order),
      products: promotions,
    );
  }
}
