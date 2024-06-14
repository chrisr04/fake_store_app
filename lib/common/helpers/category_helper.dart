import 'package:fake_store_app/common/values/values.dart';

class CategoryHelper {
  CategoryHelper._();

  static const electronics = 'electronics';
  static const womensClothing = "women's clothing";
  static const mensClothing = "men's clothing";
  static const jewelery = 'jewelery';

  static String categoryImage(String category) => switch (category) {
        electronics => AssetValue.electronicsPng,
        womensClothing => AssetValue.womenClothingPng,
        mensClothing => AssetValue.menClothingPng,
        jewelery => AssetValue.jeweleryPng,
        _ => AssetValue.electronicsPng,
      };

  static String categoryName(String category) => switch (category) {
        electronics => StringValue.electronics,
        womensClothing => StringValue.womenClothing,
        mensClothing => StringValue.menClothing,
        jewelery => StringValue.jewelery,
        _ => StringValue.electronics,
      };
}
