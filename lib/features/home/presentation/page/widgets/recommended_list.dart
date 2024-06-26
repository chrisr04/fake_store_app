part of '../home_page.dart';

class RecommendedList extends StatelessWidget {
  const RecommendedList({super.key, required this.recommended});

  final List<ProductEntity> recommended;

  @override
  Widget build(BuildContext context) {
    final semantics = context.watch<HomeSemantics>();
    return HorizontalProductList(
      title: StringValue.recommended,
      semanticTitle: semantics.recommendedSubtitle.label,
      semanticsSortKey: OrdinalSortKey(semantics.recommendedSubtitle.order),
      products: recommended,
    );
  }
}
