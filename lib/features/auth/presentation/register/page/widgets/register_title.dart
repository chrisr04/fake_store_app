part of '../register_page.dart';

class RegisterTitle extends StatelessWidget {
  const RegisterTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        bottom: FakeSpacing.xl,
      ),
      child: FakeTextHeading3(StringValue.registry),
    );
  }
}
