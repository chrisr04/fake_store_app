part of 'app_dependencies.dart';

final _authDependencies = [
  Provider<FakeAuthRemoteDataSource>(
    create: (context) => FakeAuthRemoteDataSource(
      context.read<FakeApiClient>(),
    ),
  ),
  Provider<FakeAuthRepository>(
    create: (context) => FakeAuthRepositoryImpl(
      context.read<FakeAuthRemoteDataSource>(),
    ),
  ),
  ChangeNotifierProvider<LoginViewModel>(
    create: (context) => LoginViewModel(
      context.read<FakeAuthRepository>(),
    ),
  ),
  ChangeNotifierProvider<RegisterViewModel>(
    create: (context) => RegisterViewModel(
      context.read<FakeAuthRepository>(),
    ),
  ),
  FutureProvider<LoginSemantics>(
    create: (context) => LoginSemantics.load(),
    initialData: LoginSemantics.fromJson({}),
  ),
  FutureProvider<RegisterSemantics>(
    create: (context) => RegisterSemantics.load(),
    initialData: RegisterSemantics.fromJson({}),
  ),
];
