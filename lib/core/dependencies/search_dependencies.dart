part of 'app_dependencies.dart';

final _searchDependencies = [
  Provider<FakeSearchRemoteDataSource>(
    create: (context) => FakeSearchRemoteDataSource(
      context.read<FakeApiClient>(),
    ),
  ),
  Provider<FakeSearchRepository>(
    create: (context) => FakeSearchRepositoryImpl(
      context.read<FakeSearchRemoteDataSource>(),
    ),
  ),
  ChangeNotifierProvider<SearchViewModel>(
    create: (context) => SearchViewModel(
      context.read<FakeSearchRepository>(),
    ),
  ),
];
