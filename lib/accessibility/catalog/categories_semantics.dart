import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/accessibility/semantic_node.dart';

class CategoriesSemantics {
  CategoriesSemantics({
    required this.searchBarHint,
    required this.categoryItem,
  });

  final SemanticNode searchBarHint;
  final SemanticNode categoryItem;

  factory CategoriesSemantics.fromJson(Map<String, dynamic> json) =>
      CategoriesSemantics(
        searchBarHint: SemanticNode.fromJson(
          json['searchBarHint'] ?? {},
        ),
        categoryItem: SemanticNode.fromJson(
          json['categoryItem'] ?? {},
        ),
      );

  static Future<CategoriesSemantics> load() async {
    final jsonSemantics = await AppConfig.loadSemantics(
      'assets/accessibility/catalog/categories_semantics.json',
    );
    return CategoriesSemantics.fromJson(jsonSemantics);
  }
}
