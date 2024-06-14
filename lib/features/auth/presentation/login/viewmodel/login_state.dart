part of 'login_viewmodel.dart';

enum LoginStateType { initial, loading, loggedIn, error, notFound }

class LoginState {
  LoginState({
    this.username = '',
    this.password = '',
    this.error = '',
    this.type = LoginStateType.initial,
    this.user,
  });

  final String username;
  final String password;
  final String error;
  final LoginStateType type;
  UserEntity? user;

  LoginState copyWith({
    String? username,
    String? password,
    String? error,
    LoginStateType? type,
    UserEntity? user,
  }) =>
      LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
        error: error ?? this.error,
        type: type ?? this.type,
        user: user ?? this.user,
      );
}
