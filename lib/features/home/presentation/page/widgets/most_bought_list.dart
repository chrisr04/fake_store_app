part of '../home_page.dart';

class MostBoughtList extends StatelessWidget {
  const MostBoughtList({super.key, required this.mostBought});

  final List<ProductEntity> mostBought;

  @override
  Widget build(BuildContext context) {
    final semantics = context.watch<HomeSemantics>();
    return HorizontalProductList(
      title: StringValue.mostBought,
      semanticTitle: semantics.mostBoughtSubtitle.label,
      semanticsSortKey: OrdinalSortKey(semantics.mostBoughtSubtitle.order),
      products: mostBought,
    );
  }
}
