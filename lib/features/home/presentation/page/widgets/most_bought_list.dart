part of '../home_page.dart';

class MostBoughtList extends StatelessWidget {
  const MostBoughtList({super.key, required this.mostBought});

  final List<ProductEntity> mostBought;

  @override
  Widget build(BuildContext context) {
    return HorizontalProductList(
      title: StringValue.mostBought,
      products: mostBought,
    );
  }
}
