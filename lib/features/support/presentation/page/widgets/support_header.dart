part of '../support_page.dart';

class SupportHeader extends StatelessWidget {
  const SupportHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            focused: true,
            child: FakeTextHeading3(
              StringValue.helloDoYouNeedHelp,
              weight: FontWeight.w600,
            ),
          ),
          const FakeSpacerS(),
          FakeTextLarge(
            StringValue.weAreHereForHelpYouContactUs,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          const FakeSpacerL(),
          FakeAvatarStack(
            images: List.generate(
              5,
              (index) => AssetImage(
                AssetValue.supportFaceJpg(index + 1),
              ),
            ),
          ),
          const FakeSpacerL(),
        ],
      ),
    );
  }
}
