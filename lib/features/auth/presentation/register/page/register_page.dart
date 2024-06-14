import 'package:fake_store_app/core/core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:fake_store_app/navigation/navigation.dart';
import 'package:fake_store_app/features/auth/presentation/register/viewmodel/register_viewmodel.dart';

part 'widgets/register_title.dart';
part 'widgets/register_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final viewModel = context.read<RegisterViewModel>();
  @override
  void initState() {
    viewModel.addListener(_viewModelListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FakeLightAppBar(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: FakeSpacing.lg,
                ).copyWith(
                  bottom: FakeSpacing.xxl,
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RegisterTitle(),
                    RegisterForm(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    viewModel.removeListener(_viewModelListener);
    super.dispose();
  }

  void _viewModelListener() {
    final state = context.read<RegisterViewModel>().state;
    switch (state.type) {
      case RegisterStateType.loading:
        FakeModalLoading.show(context, loadingText: StringValue.creatingUser);
        break;
      case RegisterStateType.error:
        FakeNavigator.root.pop();
        FakeSnackBar.showError(context, message: state.error);
        break;
      case RegisterStateType.signedUp:
        FakeModalSuccess.show(
          context,
          canClose: false,
          title: StringValue.registrySuccessfully,
          buttonLabel: StringValue.continueText,
          onPressedButton: () {
            context.read<AppConfig>().setLoggedUser(state.user!);
            FakeNavigator.root.pushNamedAndRemoveUntil(
              AppRoutes.menu,
              (_) => false,
            );
          },
        );
        break;
      default:
    }
  }
}
