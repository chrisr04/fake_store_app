part of '../register_page.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExcludeSemantics(
            child: FakeTextLarge(
              StringValue.name,
              weight: FontWeight.w600,
              textAlign: TextAlign.start,
            ),
          ),
          FakeTextField(
            key: KeyValue.registerNameInput,
            hintText: StringValue.writeYourName,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: FormValidatorHelper.isRequired,
          ),
          const FakeSpacerM(),
          ExcludeSemantics(
            child: FakeTextLarge(
              StringValue.lastName,
              weight: FontWeight.w600,
              textAlign: TextAlign.start,
            ),
          ),
          FakeTextField(
            key: KeyValue.registerLastNameInput,
            hintText: StringValue.writeYourLastName,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: FormValidatorHelper.isRequired,
          ),
          const FakeSpacerM(),
          ExcludeSemantics(
            child: FakeTextLarge(
              StringValue.email,
              weight: FontWeight.w600,
              textAlign: TextAlign.start,
            ),
          ),
          FakeTextField(
            key: KeyValue.registerEmailInput,
            hintText: StringValue.writeYourEmail,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: FormValidatorHelper.isRequiredEmail,
          ),
          const FakeSpacerM(),
          ExcludeSemantics(
            child: FakeTextLarge(
              StringValue.phone,
              weight: FontWeight.w600,
              textAlign: TextAlign.start,
            ),
          ),
          FakeTextField(
            key: KeyValue.registerPhoneInput,
            hintText: StringValue.writeYourPhone,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: FormValidatorHelper.isRequired,
          ),
          const FakeSpacerM(),
          ExcludeSemantics(
            child: FakeTextLarge(
              StringValue.user,
              weight: FontWeight.w600,
              textAlign: TextAlign.start,
            ),
          ),
          FakeTextField(
            key: KeyValue.registerUsernameInput,
            hintText: StringValue.writeYourUserName,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: FormValidatorHelper.isRequired,
          ),
          const FakeSpacerM(),
          ExcludeSemantics(
            child: FakeTextLarge(
              StringValue.password,
              weight: FontWeight.w600,
              textAlign: TextAlign.start,
            ),
          ),
          FakeTextFieldObscure(
            key: KeyValue.registerPasswordInput,
            hintText: StringValue.writeYourPassword,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: FormValidatorHelper.isRequired,
          ),
          const FakeSpacerXL(),
          Semantics(
            sortKey: const OrdinalSortKey(double.maxFinite),
            child: SizedBox(
              width: double.infinity,
              child: FakeButtonPrimary(
                key: KeyValue.registerSignUpBtn,
                onPressed: _onTapButton,
                size: FakeButtonSize.large,
                label: StringValue.signUp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onTapButton() {
    final formState = _formKey.currentState;
    if (formState == null || !formState.validate()) return;
    final viewModel = context.read<RegisterViewModel>();
    final user = UserEntity(
      id: 0,
      name: UserNameEntity(
        firstname: viewModel.state.name,
        lastname: viewModel.state.lastname,
      ),
      username: viewModel.state.username,
      email: viewModel.state.email,
      phone: viewModel.state.phone,
      address: const AddressEntity(
        city: '',
        street: '',
        zipcode: '',
        number: 0,
        geolocation: GeolocationEntity(
          lat: '',
          long: '',
        ),
      ),
    );
    viewModel.onRegister(user);
  }
}
