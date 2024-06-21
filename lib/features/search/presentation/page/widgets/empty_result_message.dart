part of '../search_page.dart';

class EmptyResultMessage extends StatelessWidget {
  const EmptyResultMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: FakeInformationTemplate(
            imagePath: AssetValue.emptySearchIllustrationPng,
            message: StringValue.weCantFindResults,
          ),
        ),
      ],
    );
  }
}
