import 'package:fake_api/fake_api.dart';
import 'package:flutter/material.dart';
import 'package:fake_store_app/features/auth/domain/domain.dart';
import 'package:fake_store_app/features/auth/presentation/register/helpers/register_form_field.dart';

part 'register_state.dart';

class RegisterViewModel with ChangeNotifier {
  RegisterViewModel(this._repository);

  final FakeAuthRepository _repository;
  RegisterState _state = RegisterState();
  RegisterState get state => _state;

  void onChangedField({
    required RegisterFormField field,
    required String value,
  }) {
    switch (field) {
      case RegisterFormField.name:
        _state = _state.copyWith(
          name: value,
          type: RegisterStateType.formChanged,
        );
        break;
      case RegisterFormField.lastname:
        _state = _state.copyWith(
          lastname: value,
          type: RegisterStateType.formChanged,
        );
        break;
      case RegisterFormField.email:
        _state = _state.copyWith(
          email: value,
          type: RegisterStateType.formChanged,
        );
        break;
      case RegisterFormField.phone:
        _state = _state.copyWith(
          phone: value,
          type: RegisterStateType.formChanged,
        );
        break;
      case RegisterFormField.username:
        _state = _state.copyWith(
          username: value,
          type: RegisterStateType.formChanged,
        );
        break;
      case RegisterFormField.password:
        _state = _state.copyWith(
          password: value,
          type: RegisterStateType.formChanged,
        );
        break;
    }
    notifyListeners();
  }

  Future<void> onRegister(UserEntity user) async {
    _state = _state.copyWith(type: RegisterStateType.loading);
    notifyListeners();

    final failureOrSigned = await _repository.signUp(
      user,
    );
    final signUpResult = failureOrSigned.fold(
      () {},
      (failure) => failure,
    );

    if (failureOrSigned.isSome()) {
      final failure = signUpResult as Failure;
      _state = _state.copyWith(
        error: failure.message,
        type: RegisterStateType.error,
      );
      notifyListeners();
      return;
    }

    final failureOrUsers = await _repository.getUsers();

    failureOrUsers.fold(
      (failure) {
        _state = _state.copyWith(
          type: RegisterStateType.error,
          error: failure.message,
        );
      },
      (users) {
        _state = _state.copyWith(
          user: users.first,
          type: RegisterStateType.signedUp,
        );
      },
    );
    notifyListeners();
  }
}
