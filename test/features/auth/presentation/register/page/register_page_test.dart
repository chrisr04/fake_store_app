import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_app/core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/features/auth/auth.dart';
import 'package:fake_store_app/navigation/navigation.dart';
import 'package:fake_store_app/accessibility/accessibility.dart';

class MockAppConfig extends Mock implements AppConfig {}

class MockFakeAuthRepository extends Mock implements FakeAuthRepository {}

class MockRegisterViewModel extends RegisterViewModel {
  MockRegisterViewModel(super.repository);

  RegisterState _fakeState = RegisterState();

  @override
  RegisterState get state => _fakeState;

  void changeStateAndNotify(RegisterState newState) {
    _fakeState = newState;
    notifyListeners();
  }
}

void main() {
  late MockRegisterViewModel registerViewModel;
  late MockFakeAuthRepository repository;
  late MockAppConfig appConfig;
  late UserEntity user;

  setUp(() async {
    await AppConfig.initAssets();
    repository = MockFakeAuthRepository();
    registerViewModel = MockRegisterViewModel(repository);
    appConfig = MockAppConfig();
    user = const UserEntity(
      id: 1,
      name: UserNameEntity(
        firstname: 'John',
        lastname: 'Doe',
      ),
      username: 'johndoe',
      email: 'john.doe@example.com',
      phone: '123-456-7890',
      address: AddressEntity(
        city: 'New York',
        street: '123 Main St',
        zipcode: '10001',
        number: 1,
        geolocation: GeolocationEntity(
          lat: '34.5464',
          long: '345.343',
        ),
      ),
    );

    when(
      () => repository.signUp(user),
    ).thenAnswer((_) async => const None());

    when(() => repository.getUsers()).thenAnswer((_) async => const Right([]));
  });

  Widget createWidget() => MultiProvider(
        providers: [
          ChangeNotifierProvider<RegisterViewModel>.value(
            value: registerViewModel,
          ),
          FutureProvider<RegisterSemantics>(
            create: (context) => RegisterSemantics.load(),
            initialData: RegisterSemantics.fromJson({}),
          ),
          Provider<AppConfig>.value(value: appConfig),
        ],
        child: MaterialApp(
          navigatorKey: FakeNavigator.rootNavigatorKey,
          home: const RegisterPage(),
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(
                child: Text('Home'),
              ),
            ),
          ),
        ),
      );

  group('RegisterPage', () {
    testWidgets('should displays all required elements',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byType(RegisterTitle), findsOneWidget);
      expect(find.byType(RegisterForm), findsOneWidget);
    });

    testWidgets('should displays a loading modal when state type is loading',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidget());

      registerViewModel.changeStateAndNotify(
        RegisterState(
          type: RegisterStateType.loading,
        ),
      );
      await tester.pump();

      expect(find.text(StringValue.creatingUser), findsOneWidget);
    });

    testWidgets('should displays a error when state type is error',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidget());

      registerViewModel.changeStateAndNotify(
        RegisterState(
          type: RegisterStateType.loading,
        ),
      );
      await tester.pump();

      registerViewModel.changeStateAndNotify(
        RegisterState(
          type: RegisterStateType.error,
          error: 'Login error',
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Login error'), findsOneWidget);
    });

    testWidgets(
        'should show success modal, call to setLoggedUser and navigate to home page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidget());

      registerViewModel.changeStateAndNotify(
        RegisterState(
          type: RegisterStateType.loading,
        ),
      );
      await tester.pump();

      registerViewModel.changeStateAndNotify(
        RegisterState(
          type: RegisterStateType.signedUp,
          user: user,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(StringValue.registrySuccessfully), findsOneWidget);

      await tester.tap(find.text(StringValue.continueText));
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
      verify(() => appConfig.setLoggedUser(user)).called(1);
    });
  });
}
