part of '../product_detail_page.dart';

class DetailHeader extends StatelessWidget {
  const DetailHeader({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          Positioned(
            bottom: FakeSpacing.lg,
            left: 0.0,
            right: 0.0,
            child: ExcludeSemantics(
              child: FakeImageNetwork(
                url: product.image,
                height: 200.0,
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Theme.of(context).colorScheme.shadowVariant,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: Semantics(
              sortKey: const OrdinalSortKey(double.maxFinite),
              child: const FakeLightAppBar(),
            ),
          ),
        ],
      ),
    );
  }
}
