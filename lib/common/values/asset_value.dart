import 'package:fake_store_app/core/core.dart';

abstract class AssetValue {
  static String get welcomeIllustrationPng =>
      AppConfig.getImage('welcomeIllustrationPng');
  static String get loginIllustrationPng =>
      AppConfig.getImage('loginIllustrationPng');
  static String get registerIllustrationPng =>
      AppConfig.getImage('registerIllustrationPng');
  static String get electronicsPng => AppConfig.getImage('electronicsPng');
  static String get womenClothingPng => AppConfig.getImage('womenClothingPng');
  static String get menClothingPng => AppConfig.getImage('menClothingPng');
  static String get jeweleryPng => AppConfig.getImage('jeweleryPng');
  static String supportFaceJpg(int number) =>
      AppConfig.getImage('supportFace${number}Jpg');
  static String get searchIllustrationPng =>
      AppConfig.getImage('searchIllustrationPng');
  static String get emptySearchIllustrationPng =>
      AppConfig.getImage('emptySearchIllustrationPng');
  static String get emptyCartIllustrationPng =>
      AppConfig.getImage('emptyCartIllustrationPng');
  static String get errorIllustrationPng =>
      AppConfig.getImage('errorIllustrationPng');
  static String get notFoundIllustrationPng =>
      AppConfig.getImage('notFoundIllustrationPng');
}
