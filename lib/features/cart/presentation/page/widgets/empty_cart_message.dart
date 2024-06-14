part of '../cart_page.dart';

class EmptyCartMessage extends StatelessWidget {
  const EmptyCartMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: FakeInformationTemplate(
          imagePath: AssetValue.emptyCartIllustrationPng,
          message: StringValue.thereAreNotProductsYet,
        ),
      ),
    );
  }
}
