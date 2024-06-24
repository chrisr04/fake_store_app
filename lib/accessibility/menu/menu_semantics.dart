import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/accessibility/semantic_node.dart';

class MenuSemantics {
  MenuSemantics({
    required this.homeItem,
    required this.catalogItem,
    required this.supportItem,
    required this.cartItemCount,
    required this.cartItem,
  });

  final SemanticNode homeItem;
  final SemanticNode catalogItem;
  final SemanticNode supportItem;
  final SemanticNode cartItemCount;
  final SemanticNode cartItem;

  factory MenuSemantics.fromJson(Map<String, dynamic> json) => MenuSemantics(
        homeItem: SemanticNode.fromJson(
          json['homeItem'] ?? {},
        ),
        catalogItem: SemanticNode.fromJson(
          json['catalogItem'] ?? {},
        ),
        supportItem: SemanticNode.fromJson(
          json['supportItem'] ?? {},
        ),
        cartItemCount: SemanticNode.fromJson(
          json['cartItemCount'] ?? {},
        ),
        cartItem: SemanticNode.fromJson(
          json['cartItem'] ?? {},
        ),
      );

  static Future<MenuSemantics> load() async {
    final jsonSemantics = await AppConfig.loadSemantics(
      'assets/accessibility/menu/menu_semantics.json',
    );
    return MenuSemantics.fromJson(jsonSemantics);
  }
}
