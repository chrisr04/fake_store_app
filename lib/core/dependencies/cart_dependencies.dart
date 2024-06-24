part of 'app_dependencies.dart';

final _cartDependencies = [
  Provider<FakeCartRemoteDataSource>(
    create: (context) => FakeCartRemoteDataSource(
      context.read<FakeApiClient>(),
    ),
  ),
  Provider<FakeCartRepository>(
    create: (context) => FakeCartRepositoryImpl(
      context.read<FakeCartRemoteDataSource>(),
    ),
  ),
  ChangeNotifierProvider<CartViewModel>(
    create: (context) => CartViewModel(
      context.read<FakeCartRepository>(),
    ),
  ),
  FutureProvider<CartSemantics>(
    create: (context) => CartSemantics.load(),
    initialData: CartSemantics.fromJson({}),
  ),
];
