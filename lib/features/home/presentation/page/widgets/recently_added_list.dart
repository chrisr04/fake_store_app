part of '../home_page.dart';

class RecentlyAddedList extends StatelessWidget {
  const RecentlyAddedList({super.key, required this.recentlyAdded});

  final List<ProductEntity> recentlyAdded;

  @override
  Widget build(BuildContext context) {
    final semantics = context.watch<HomeSemantics>();
    return HorizontalProductList(
      title: StringValue.recentlyAdded,
      semanticTitle: semantics.recentlyAddedSubtitle.label,
      semanticsSortKey: OrdinalSortKey(semantics.recentlyAddedSubtitle.order),
      products: recentlyAdded,
    );
  }
}
