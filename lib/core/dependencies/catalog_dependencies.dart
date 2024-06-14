part of 'app_dependencies.dart';

final _catalogDependencies = [
  Provider<FakeCatalogRemoteDataSource>(
    create: (context) => FakeCatalogRemoteDataSource(
      context.read<FakeApiClient>(),
    ),
  ),
  Provider<FakeCatalogRepository>(
    create: (context) => FakeCatalogRepositoryImpl(
      context.read<FakeCatalogRemoteDataSource>(),
    ),
  ),
  ChangeNotifierProvider<CategoryDetailViewModel>(
    create: (context) => CategoryDetailViewModel(
      context.read<FakeCatalogRepository>(),
    ),
  ),
];
