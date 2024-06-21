part of '../login_page.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FakeImageAsset(
          path: AssetValue.loginIllustrationPng,
          height: 200.0,
        ),
        const FakeSpacerXL(),
        FakeTextHeading3(StringValue.login),
        const FakeSpacerL(),
      ],
    );
  }
}
