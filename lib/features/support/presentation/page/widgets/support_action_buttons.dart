part of '../support_page.dart';

class SupportActionButtons extends StatelessWidget {
  const SupportActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FakeButtonPrimary(
            onPressed: () {},
            label: StringValue.writeUs,
            size: FakeButtonSize.large,
          ),
        ),
        const FakeSpacerM(axis: FakeSpacerAxis.x),
        Expanded(
          child: FakeButtonOutlinedPrimary(
            onPressed: () {},
            label: StringValue.callUs,
            size: FakeButtonSize.large,
          ),
        ),
      ],
    );
  }
}
