part of 'app_dependencies.dart';

final _homeDepdencencies = [
  Provider<FakeHomeRemoteDataSource>(
    create: (context) => FakeHomeRemoteDataSource(
      context.read<FakeApiClient>(),
    ),
  ),
  Provider<FakeHomeRepository>(
    create: (context) => FakeHomeRepositoryImpl(
      context.read<FakeHomeRemoteDataSource>(),
    ),
  ),
  ChangeNotifierProvider<HomeViewModel>(
    create: (context) => HomeViewModel(
      context.read<FakeHomeRepository>(),
    )..onLoadSections(),
  ),
];
