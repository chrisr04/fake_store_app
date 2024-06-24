part of '../search_page.dart';

class EmptyResultMessage extends StatelessWidget {
  const EmptyResultMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      sortKey: const OrdinalSortKey(double.maxFinite),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: FakeInformationTemplate(
              imagePath: AssetValue.emptySearchIllustrationPng,
              message: StringValue.weCantFindResults,
            ),
          ),
        ],
      ),
    );
  }
}
