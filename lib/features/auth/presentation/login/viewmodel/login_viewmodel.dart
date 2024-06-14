import 'package:fake_api/fake_api.dart';
import 'package:flutter/material.dart';
import 'package:fake_store_app/features/auth/domain/domain.dart';

part 'login_state.dart';

class LoginViewModel with ChangeNotifier {
  LoginViewModel(this._repository);

  final FakeAuthRepository _repository;
  LoginState state = LoginState();

  void onChangeUserName(String username) {
    state = state.copyWith(
      username: username,
      type: LoginStateType.initial,
    );
    notifyListeners();
  }

  void onChangePassword(String password) {
    state = state.copyWith(
      password: password,
      type: LoginStateType.initial,
    );
    notifyListeners();
  }

  void onLogIn() async {
    state = state.copyWith(type: LoginStateType.loading);
    notifyListeners();
    final failureOrToken = await _repository.logIn(
      username: state.username,
      password: state.password,
    );
    final tokenResult = failureOrToken.fold(
      (failure) => failure,
      (token) => token,
    );

    if (failureOrToken.isLeft()) {
      final failure = tokenResult as Failure;
      state = state.copyWith(
        error: failure.message,
        type: LoginStateType.error,
      );
      notifyListeners();
      return;
    }

    final failureOrUsers = await _repository.getUsers();

    failureOrUsers.fold(
      (failure) {
        state = state.copyWith(
          type: LoginStateType.error,
          error: failure.message,
        );
      },
      (users) {
        final loggedUser =
            users.where((user) => user.username == state.username);
        if (loggedUser.isEmpty) {
          state = state.copyWith(type: LoginStateType.notFound);
        } else {
          state = state.copyWith(
            user: loggedUser.first,
            type: LoginStateType.loggedIn,
          );
        }
      },
    );
    notifyListeners();
  }
}
