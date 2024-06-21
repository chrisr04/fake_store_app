import 'package:fake_api/fake_api.dart';
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
    await AppConfig.init();
    appConfig = MockAppConfig();
  });

  testWidgets('AddressRow displays user address correctly',
      (WidgetTester tester) async {
    const user = UserEntity(
      id: 1,
      name: UserNameEntity(
        firstname: 'John',
        lastname: 'Doe',
      ),
      username: 'johndoe',
      email: 'john.doe@example.com',
      phone: '123-456-7890',
      address: AddressEntity(
        city: 'Springfield',
        street: 'Main St',
        zipcode: '12345',
        number: 123,
        geolocation: GeolocationEntity(
          lat: '34.5464',
          long: '345.343',
        ),
      ),
    );

    when(() => appConfig.currentUser).thenReturn(user);

    await tester.pumpWidget(
      Provider<AppConfig>(
        create: (context) => appConfig,
        child: const MaterialApp(
          home: Scaffold(
            body: AddressRow(),
          ),
        ),
      ),
    );

    expect(find.text('123 Main St, Springfield, 12345'), findsOneWidget);
  });

  testWidgets('AddressRow displays empty string when user is null',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<AppConfig>(
        create: (context) => appConfig,
        child: const MaterialApp(
          home: Scaffold(
            body: AddressRow(),
          ),
        ),
      ),
    );

    expect(find.text(''), findsOneWidget);
  });
}
