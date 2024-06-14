part of '../home_page.dart';

class RecommendedList extends StatelessWidget {
  const RecommendedList({super.key, required this.recommended});

  final List<ProductEntity> recommended;

  @override
  Widget build(BuildContext context) {
    return HorizontalProductList(
      title: StringValue.recommended,
      products: recommended,
    );
  }
}
