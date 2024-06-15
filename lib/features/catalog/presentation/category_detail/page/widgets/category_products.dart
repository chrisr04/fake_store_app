part of '../category_detail_page.dart';

class CategoryProducts extends StatelessWidget {
  const CategoryProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CategoryDetailViewModel>().state;
    return switch (state.type) {
      CategoryDetailStateType.loaded => VerticalProductSliverList(
          products: state.products,
        ),
      CategoryDetailStateType.error => ErrorMessage(error: state.error),
      _ => const SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
    };
  }
}
