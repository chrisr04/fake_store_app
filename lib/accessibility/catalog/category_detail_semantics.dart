import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/accessibility/semantic_node.dart';

class CategoryDetailSemantics {
  CategoryDetailSemantics({
    required this.searchBarHint,
    required this.categoryTitle,
  });

  final SemanticNode searchBarHint;
  final SemanticNode categoryTitle;

  factory CategoryDetailSemantics.fromJson(Map<String, dynamic> json) =>
      CategoryDetailSemantics(
        searchBarHint: SemanticNode.fromJson(
          json['searchBarHint'] ?? {},
        ),
        categoryTitle: SemanticNode.fromJson(
          json['categoryTitle'] ?? {},
        ),
      );

  static Future<CategoryDetailSemantics> load() async {
    final jsonSemantics = await AppConfig.loadSemantics(
      'assets/accessibility/catalog/category_detail_semantics.json',
    );
    return CategoryDetailSemantics.fromJson(jsonSemantics);
  }
}
