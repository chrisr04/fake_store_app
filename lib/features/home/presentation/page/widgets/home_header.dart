part of '../home_page.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverPersistentHeader(
      pinned: true,
      delegate: _HomeHeaderDelegate(),
    );
  }
}

class _HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _HomeHeaderDelegate();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = 1 - (shrinkOffset / maxExtent);
    final barPosition =
        FakeSpacing.xl + progress * (FakeSpacing.xl + FakeSpacing.xs);

    return SizedBox(
      height: maxExtent,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 95.0,
            color: Theme.of(context).colorScheme.surfaceVariant,
            padding: const EdgeInsets.symmetric(
              vertical: FakeSpacing.sm,
              horizontal: FakeSpacing.md,
            ),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: progress,
              child: const AddressRow(),
            ),
          ),
          AnimatedPositioned(
            top: barPosition,
            left: 0.0,
            right: 0.0,
            duration: const Duration(milliseconds: 100),
            child: const HomeSearchBar(),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 123.0;

  @override
  double get minExtent => 123.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
