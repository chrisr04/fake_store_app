part of '../category_detail_page.dart';

class CategoryHeader extends StatelessWidget {
  const CategoryHeader({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: FakeSpacing.md,
        ).copyWith(
          top: FakeSpacing.sl,
        ),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.shadowVariant,
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 16.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(FakeSpacing.sl),
                child: FakeImageAsset(
                  path: CategoryHelper.categoryImage(category),
                  width: 50.0,
                ),
              ),
            ),
            const FakeSpacerM(axis: FakeSpacerAxis.x),
            Flexible(
              child: FakeTextHeading6(
                CategoryHelper.categoryName(category),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
