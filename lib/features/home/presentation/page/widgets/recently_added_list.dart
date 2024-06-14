part of '../home_page.dart';

class RecentlyAddedList extends StatelessWidget {
  const RecentlyAddedList({super.key, required this.recentlyAdded});

  final List<ProductEntity> recentlyAdded;

  @override
  Widget build(BuildContext context) {
    return HorizontalProductList(
      title: StringValue.recentlyAdded,
      products: recentlyAdded,
    );
  }
}
