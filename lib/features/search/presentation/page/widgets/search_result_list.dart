part of '../search_page.dart';

class SearchResultList extends StatelessWidget {
  const SearchResultList({super.key, required this.products});

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const EmptyResultMessage();
    return VerticalProductList(
      products: products,
    );
  }
}
