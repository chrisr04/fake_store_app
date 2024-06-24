part of '../register_page.dart';

class RegisterTitle extends StatelessWidget {
  const RegisterTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final semantics = context.watch<RegisterSemantics>();
    return Padding(
      padding: const EdgeInsets.only(
        bottom: FakeSpacing.xl,
      ),
      child: Semantics(
        label: semantics.signUpTitle.label,
        excludeSemantics: true,
        focusable: true,
        sortKey: OrdinalSortKey(semantics.signUpTitle.order),
        child: FakeTextHeading3(StringValue.registry),
      ),
    );
  }
}
