import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/navigation/navigation.dart';
import 'package:provider/provider.dart';

part 'widgets/login_header.dart';
part 'widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final viewModel = context.read<LoginViewModel>();

  @override
  void initState() {
    Future.microtask(() {
      viewModel.addListener(_viewModelListener);
    });
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
                    LoginHeader(),
                    LoginForm(),
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
    final state = context.read<LoginViewModel>().state;
    switch (state.type) {
      case LoginStateType.loading:
        FakeModalLoading.show(context, loadingText: StringValue.loggingIn);
        break;
      case LoginStateType.error:
        FakeNavigator.root.pop();
        FakeSnackBar.showError(context, message: state.error);
        break;
      case LoginStateType.notFound:
        FakeNavigator.root.pop();
        FakeSnackBar.showError(context, message: StringValue.userNotFound);
        break;
      case LoginStateType.loggedIn:
        context.read<AppConfig>().setLoggedUser(state.user!);
        FakeNavigator.root.pushNamedAndRemoveUntil(
          AppRoutes.menu,
          (_) => false,
        );
        break;
      default:
    }
  }
}
