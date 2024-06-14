part of '../login_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginViewModel>();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(
            width: double.infinity,
            child: FakeTextLarge(
              StringValue.user,
              weight: FontWeight.w600,
              textAlign: TextAlign.start,
            ),
          ),
          FakeTextField(
            hintText: StringValue.writeYourUserName,
            validator: FormValidatorHelper.isRequired,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: viewModel.onChangeUserName,
          ),
          const FakeSpacerM(),
          const SizedBox(
            width: double.infinity,
            child: FakeTextLarge(
              StringValue.password,
              weight: FontWeight.w600,
              textAlign: TextAlign.start,
            ),
          ),
          FakeTextFieldObscure(
            hintText: StringValue.writeYourPassword,
            validator: FormValidatorHelper.isRequired,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: viewModel.onChangePassword,
          ),
          const FakeSpacerXL(),
          SizedBox(
            width: double.infinity,
            child: FakeButtonPrimary(
              onPressed: _onTapButton,
              size: FakeButtonSize.large,
              label: StringValue.signIn,
            ),
          ),
        ],
      ),
    );
  }

  void _onTapButton() {
    final formState = _formKey.currentState;
    if (formState == null || !formState.validate()) return;
    context.read<LoginViewModel>().onLogIn();
  }
}
