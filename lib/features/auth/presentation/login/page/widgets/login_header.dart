part of '../login_page.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final semantics = context.watch<LoginSemantics>();
    return Column(
      children: [
        FakeImageAsset(
          path: AssetValue.loginIllustrationPng,
          height: 200.0,
        ),
        const FakeSpacerXL(),
        Semantics(
          label: semantics.logInTitle.label,
          sortKey: OrdinalSortKey(semantics.logInTitle.order),
          excludeSemantics: true,
          child: FakeTextHeading3(StringValue.login),
        ),
        const FakeSpacerL(),
      ],
    );
  }
}
