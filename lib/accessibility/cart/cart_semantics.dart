import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/accessibility/semantic_node.dart';

class CartSemantics {
  CartSemantics({
    required this.cartTitle,
    required this.deleteButton,
    required this.addButton,
    required this.removeButton,
    required this.quantityInput,
    required this.totalResume,
  });

  final SemanticNode cartTitle;
  final SemanticNode deleteButton;
  final SemanticNode addButton;
  final SemanticNode removeButton;
  final SemanticNode quantityInput;
  final SemanticNode totalResume;

  factory CartSemantics.fromJson(Map<String, dynamic> json) => CartSemantics(
        cartTitle: SemanticNode.fromJson(
          json['cartTitle'] ?? {},
        ),
        deleteButton: SemanticNode.fromJson(
          json['deleteButton'] ?? {},
        ),
        addButton: SemanticNode.fromJson(
          json['addButton'] ?? {},
        ),
        removeButton: SemanticNode.fromJson(
          json['removeButton'] ?? {},
        ),
        quantityInput: SemanticNode.fromJson(
          json['quantityInput'] ?? {},
        ),
        totalResume: SemanticNode.fromJson(
          json['totalResume'] ?? {},
        ),
      );

  static Future<CartSemantics> load() async {
    final jsonSemantics = await AppConfig.loadSemantics(
      'assets/accessibility/cart/cart_semantics.json',
    );
    return CartSemantics.fromJson(jsonSemantics);
  }
}
