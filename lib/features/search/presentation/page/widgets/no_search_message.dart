part of '../search_page.dart';

class NoSearchMessage extends StatelessWidget {
  const NoSearchMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      sortKey: const OrdinalSortKey(double.maxFinite),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: FakeInformationTemplate(
              imagePath: AssetValue.searchIllustrationPng,
              message: StringValue.findWhatYouLikeMost,
            ),
          ),
        ],
      ),
    );
  }
}
