part of '../home_page.dart';

class PromotionList extends StatelessWidget {
  const PromotionList({super.key, required this.promotions});

  final List<ProductEntity> promotions;

  @override
  Widget build(BuildContext context) {
    return HorizontalProductList(
      title: StringValue.promotions,
      products: promotions,
    );
  }
}
