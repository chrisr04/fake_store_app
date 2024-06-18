part of 'register_viewmodel.dart';

enum RegisterStateType { initial, formChanged, loading, signedUp, error }

class RegisterState {
  RegisterState({
    this.name = '',
    this.lastname = '',
    this.email = '',
    this.phone = '',
    this.username = '',
    this.password = '',
    this.error = '',
    this.type = RegisterStateType.initial,
    this.user,
  });
  final String name;
  final String lastname;
  final String email;
  final String phone;
  final String username;
  final String password;
  final String error;
  final RegisterStateType type;
  UserEntity? user;

  RegisterState copyWith({
    String? name,
    String? lastname,
    String? email,
    String? phone,
    String? username,
    String? password,
    String? error,
    RegisterStateType? type,
    UserEntity? user,
  }) =>
      RegisterState(
        name: name ?? this.name,
        lastname: lastname ?? this.lastname,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        username: username ?? this.username,
        password: password ?? this.password,
        error: error ?? this.error,
        type: type ?? this.type,
        user: user ?? this.user,
      );
}
