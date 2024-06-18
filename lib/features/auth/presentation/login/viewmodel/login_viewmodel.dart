import 'package:fake_api/fake_api.dart';
import 'package:flutter/material.dart';
import 'package:fake_store_app/features/auth/domain/domain.dart';

part 'login_state.dart';

class LoginViewModel with ChangeNotifier {
  LoginViewModel(this._repository);

  final FakeAuthRepository _repository;
  LoginState _state = LoginState();
  LoginState get state => _state;

  void onChangeUserName(String username) {
    _state = _state.copyWith(
      username: username,
      type: LoginStateType.initial,
    );
    notifyListeners();
  }

  void onChangePassword(String password) {
    _state = _state.copyWith(
      password: password,
      type: LoginStateType.initial,
    );
    notifyListeners();
  }

  void onLogIn() async {
    _state = _state.copyWith(type: LoginStateType.loading);
    notifyListeners();
    final failureOrToken = await _repository.logIn(
      username: _state.username,
      password: _state.password,
    );
    final tokenResult = failureOrToken.fold(
      (failure) => failure,
      (token) => token,
    );

    if (failureOrToken.isLeft()) {
      final failure = tokenResult as Failure;
      _state = _state.copyWith(
        error: failure.message,
        type: LoginStateType.error,
      );
      notifyListeners();
      return;
    }

    final failureOrUsers = await _repository.getUsers();

    failureOrUsers.fold(
      (failure) {
        _state = _state.copyWith(
          type: LoginStateType.error,
          error: failure.message,
        );
      },
      (users) {
        final loggedUser =
            users.where((user) => user.username == _state.username);
        if (loggedUser.isEmpty) {
          _state = _state.copyWith(type: LoginStateType.notFound);
        } else {
          _state = _state.copyWith(
            user: loggedUser.first,
            type: LoginStateType.loggedIn,
          );
        }
      },
    );
    notifyListeners();
  }
}
