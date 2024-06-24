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
  FutureProvider<CategoriesSemantics>(
    create: (context) => CategoriesSemantics.load(),
    initialData: CategoriesSemantics.fromJson({}),
  ),
  FutureProvider<CategoryDetailSemantics>(
    create: (context) => CategoryDetailSemantics.load(),
    initialData: CategoryDetailSemantics.fromJson({}),
  ),
  FutureProvider<ProductDetailSemantics>(
    create: (context) => ProductDetailSemantics.load(),
    initialData: ProductDetailSemantics.fromJson({}),
  ),
];
