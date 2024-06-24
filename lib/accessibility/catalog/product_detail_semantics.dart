import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/accessibility/semantic_node.dart';

class ProductDetailSemantics {
  ProductDetailSemantics({
    required this.productTitle,
    required this.productPrice,
    required this.productDescription,
    required this.productCategory,
  });

  final SemanticNode productTitle;
  final SemanticNode productPrice;
  final SemanticNode productDescription;
  final SemanticNode productCategory;

  factory ProductDetailSemantics.fromJson(Map<String, dynamic> json) =>
      ProductDetailSemantics(
        productTitle: SemanticNode.fromJson(
          json['productTitle'] ?? {},
        ),
        productPrice: SemanticNode.fromJson(
          json['productPrice'] ?? {},
        ),
        productDescription: SemanticNode.fromJson(
          json['productDescription'] ?? {},
        ),
        productCategory: SemanticNode.fromJson(
          json['productCategory'] ?? {},
        ),
      );

  static Future<ProductDetailSemantics> load() async {
    final jsonSemantics = await AppConfig.loadSemantics(
      'assets/accessibility/catalog/product_detail_semantics.json',
    );
    return ProductDetailSemantics.fromJson(jsonSemantics);
  }
}
