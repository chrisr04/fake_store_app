import 'package:fake_store_app/core/core.dart';

abstract class StringValue {
  static String get welcome => AppConfig.getString('welcome');
  static String get signIn => AppConfig.getString('signIn');
  static String get signUp => AppConfig.getString('signUp');
  static String get weAreGladToHaveYouHere =>
      AppConfig.getString('weAreGladToHaveYouHere');
  static String get user => AppConfig.getString('user');
  static String get writeYourUserName =>
      AppConfig.getString('writeYourUserName');
  static String get password => AppConfig.getString('password');
  static String get writeYourPassword =>
      AppConfig.getString('writeYourPassword');
  static String get login => AppConfig.getString('login');
  static String get registry => AppConfig.getString('registry');
  static String get name => AppConfig.getString('name');
  static String get writeYourName => AppConfig.getString('writeYourName');
  static String get lastName => AppConfig.getString('lastName');
  static String get writeYourLastName =>
      AppConfig.getString('writeYourLastName');
  static String get email => AppConfig.getString('email');
  static String get writeYourEmail => AppConfig.getString('writeYourEmail');
  static String get phone => AppConfig.getString('phone');
  static String get writeYourPhone => AppConfig.getString('writeYourPhone');
  static String get registrySuccessfully =>
      AppConfig.getString('registrySuccessfully');
  static String get continueText => AppConfig.getString('continueText');
  static String get home => AppConfig.getString('home');
  static String get catalog => AppConfig.getString('catalog');
  static String get support => AppConfig.getString('support');
  static String get cart => AppConfig.getString('cart');
  static String get searchInFakeStore =>
      AppConfig.getString('searchInFakeStore');
  static String get promotions => AppConfig.getString('promotions');
  static String get mostBought => AppConfig.getString('mostBought');
  static String get recentlyAdded => AppConfig.getString('recentlyAdded');
  static String get recommended => AppConfig.getString('recommended');
  static String get helloDoYouNeedHelp =>
      AppConfig.getString('helloDoYouNeedHelp');
  static String get weAreHereForHelpYouContactUs =>
      AppConfig.getString('weAreHereForHelpYouContactUs');
  static String get writeUs => AppConfig.getString('writeUs');
  static String get callUs => AppConfig.getString('callUs');
  static String get fastSolutions => AppConfig.getString('fastSolutions');
  static String get problemWithOrders =>
      AppConfig.getString('problemWithOrders');
  static String get problemWithBillingData =>
      AppConfig.getString('problemWithBillingData');
  static String get problemWithAddress =>
      AppConfig.getString('problemWithAddress');
  static String get tutorials => AppConfig.getString('tutorials');
  static String get electronics => AppConfig.getString('electronics');
  static String get womenClothing => AppConfig.getString('womenClothing');
  static String get menClothing => AppConfig.getString('menClothing');
  static String get jewelery => AppConfig.getString('jewelery');
  static String get myCart => AppConfig.getString('myCart');
  static String get delete => AppConfig.getString('delete');
  static String get total => AppConfig.getString('total');
  static String get checkout => AppConfig.getString('checkout');
  static String get category => AppConfig.getString('category');
  static String get addToCart => AppConfig.getString('addToCart');
  static String get buy => AppConfig.getString('buy');
  static String get findWhatYouLikeMost =>
      AppConfig.getString('findWhatYouLikeMost');
  static String get searchByNameOrDescription =>
      AppConfig.getString('searchByNameOrDescription');
  static String get weCantFindResults =>
      AppConfig.getString('weCantFindResults');
  static String get thereAreNotProductsYet =>
      AppConfig.getString('thereAreNotProductsYet');
  static String get removeFromCart => AppConfig.getString('removeFromCart');
  static String get thisFieldIsRequired =>
      AppConfig.getString('thisFieldIsRequired');
  static String get thisFieldMustContainIntegerNumbers =>
      AppConfig.getString('thisFieldMustContainIntegerNumbers');
  static String get thisFieldMustContainValidEmail =>
      AppConfig.getString('thisFieldMustContainValidEmail');
  static String get creatingUser => AppConfig.getString('creatingUser');
  static String get userNotFound => AppConfig.getString('userNotFound');
  static String get loggingIn => AppConfig.getString('loggingIn');
  static String get back => AppConfig.getString('back');
  static String get routeNotFound => AppConfig.getString('routeNotFound');
  static String get pleaseCheckThePath =>
      AppConfig.getString('pleaseCheckThePath');
  static String get error => AppConfig.getString('error');
}
