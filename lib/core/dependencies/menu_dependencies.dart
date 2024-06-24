part of 'app_dependencies.dart';

final _menuDepdencencies = [
  FutureProvider<MenuSemantics>(
    create: (context) => MenuSemantics.load(),
    initialData: MenuSemantics.fromJson({}),
  ),
];
