import 'package:fake_store_app/accessibility/accessibility.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/features/catalog/catalog.dart';
import 'package:fake_store_app/navigation/navigation.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockCategoryDetailViewModel extends Mock
    implements CategoryDetailViewModel {}

void main() {
  setUpAll(() async {
    await AppConfig.initAssets();
  });

  testWidgets(
      'CategoryDetailPage show widgets correctly and navigate to search',
      (WidgetTester tester) async {
    final mockViewModel = MockCategoryDetailViewModel();
    when(() => mockViewModel.state).thenReturn(
      const CategoryDetailState(type: CategoryDetailStateType.initial),
    );
    when(() => mockViewModel.onLoadProducts('electronics')).thenAnswer(
      (_) => Future<void>.value(),
    );

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<CategoryDetailViewModel>(
            create: (_) => mockViewModel,
          ),
          FutureProvider<CategoryDetailSemantics>(
            create: (context) => CategoryDetailSemantics.load(),
            initialData: CategoryDetailSemantics.fromJson({}),
          ),
        ],
        child: MaterialApp(
          navigatorKey: FakeNavigator.menuNavigatorKey,
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(
                child: Text('Search'),
              ),
            ),
          ),
          home: const CategoryDetailPage(
            category: 'electronics',
          ),
        ),
      ),
    );

    expect(find.byType(FakeSearchAppBar), findsOneWidget);
    expect(find.text(StringValue.searchInFakeStore), findsOneWidget);
    expect(find.byType(CategoryHeader), findsOneWidget);
    expect(
      find.text(CategoryHelper.categoryName('electronics')),
      findsOneWidget,
    );

    expect(find.byType(CategoryProducts), findsOneWidget);

    verify(() => mockViewModel.onLoadProducts('electronics')).called(1);

    await tester.tap(find.byType(FakeSearchAppBar));
    await tester.pumpAndSettle();

    expect(find.text('Search'), findsOneWidget);
  });
}
