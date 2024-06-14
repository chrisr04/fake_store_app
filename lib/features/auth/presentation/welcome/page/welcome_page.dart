import 'package:flutter/material.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/navigation/navigation.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: FakeSpacing.lg,
                  vertical: FakeSpacing.xl,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FakeImageAsset(
                      path: AssetValue.welcomeIllustrationPng,
                      height: 250.0,
                    ),
                    const FakeSpacerXXL(),
                    const FakeTextHeading3(StringValue.welcome),
                    const FakeSpacerS(),
                    FakeTextMedium(
                      StringValue.weAreGladToHaveYouHere,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      textAlign: TextAlign.center,
                    ),
                    const FakeSpacerXL(),
                    SizedBox(
                      width: double.infinity,
                      child: FakeButtonPrimary(
                        onPressed: () => FakeNavigator.root.pushNamed(
                          AppRoutes.login,
                        ),
                        label: StringValue.signIn,
                        size: FakeButtonSize.large,
                      ),
                    ),
                    const FakeSpacerS(),
                    SizedBox(
                      width: double.infinity,
                      child: FakeButtonOutlinedPrimary(
                        onPressed: () => FakeNavigator.root.pushNamed(
                          AppRoutes.register,
                        ),
                        label: StringValue.signUp,
                        size: FakeButtonSize.large,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
