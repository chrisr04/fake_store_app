part of '../support_page.dart';

class FastSolutionsList extends StatelessWidget {
  const FastSolutionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FakeSpacerL(),
        FakeTextHeading4(
          StringValue.fastSolutions,
          weight: FontWeight.w600,
        ),
        const FakeSpacerM(),
        FakeInformationCard(
          onTap: () {},
          title: StringValue.problemWithOrders,
          titleWeight: FontWeight.w500,
        ),
        const FakeSpacerM(),
        FakeInformationCard(
          onTap: () {},
          title: StringValue.problemWithBillingData,
          titleWeight: FontWeight.w500,
        ),
        const FakeSpacerM(),
        FakeInformationCard(
          onTap: () {},
          title: StringValue.problemWithAddress,
          titleWeight: FontWeight.w500,
        ),
        const FakeSpacerM(),
        FakeInformationCard(
          onTap: () {},
          title: StringValue.tutorials,
          titleWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
