import 'package:fake_store_app/accessibility/accessibility.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/features/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockAppConfig extends Mock implements AppConfig {}

void main() {
  late MockAppConfig appConfig;

  setUp(() async {
    await AppConfig.initAssets();
    appConfig = MockAppConfig();
  });

  testWidgets('HomeHeader widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<AppConfig>(
            create: (context) => appConfig,
          ),
          FutureProvider<HomeSemantics>(
            create: (context) => HomeSemantics.load(),
            initialData: HomeSemantics.fromJson({}),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: CustomScrollView(
              slivers: [
                const HomeHeader(),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        height: 100.0,
                        color: index.isEven ? Colors.grey : Colors.white,
                      );
                    },
                    childCount: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.byType(AddressRow), findsOneWidget);
    expect(find.byType(HomeSearchBar), findsOneWidget);
    expect(find.byType(SliverPersistentHeader), findsOneWidget);
  });
}
