import 'package:fake_api/fake_api.dart';

class AppConfig {
  AppConfig._();
  static final AppConfig _instance = AppConfig._();

  factory AppConfig() => _instance;

  UserEntity? _user;

  UserEntity? get currentUser => _user;

  void setLoggedUser(UserEntity user) {
    _user = user;
  }
}
