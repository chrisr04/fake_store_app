part of 'app_dependencies.dart';

final _coreDependencies = [
  Provider<AppConfig>(
    create: (context) => AppConfig(),
  ),
  Provider<FakeApiClient>(
    create: (context) => FakeApiClient()..init(),
  ),
];
