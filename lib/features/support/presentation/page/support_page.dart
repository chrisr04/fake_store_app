import 'package:fake_store_app/common/common.dart';
import 'package:flutter/material.dart';
import 'package:fake_store_ds/fake_store_ds.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: FakeSpacing.md,
            vertical: FakeSpacing.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FakeTextHeading3(
                StringValue.helloDoYouNeedHelp,
                weight: FontWeight.w600,
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
              Row(
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
              ),
              const FakeSpacerL(),
              const FakeTextHeading4(
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
          ),
        ),
      ),
    );
  }
}
