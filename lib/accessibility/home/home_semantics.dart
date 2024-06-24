import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/accessibility/semantic_node.dart';

class HomeSemantics {
  HomeSemantics({
    required this.address,
    required this.searchBarHint,
    required this.promotionSubtitle,
    required this.mostBoughtSubtitle,
    required this.recommendedSubtitle,
    required this.recentlyAddedSubtitle,
  });

  final SemanticNode address;
  final SemanticNode searchBarHint;
  final SemanticNode promotionSubtitle;
  final SemanticNode mostBoughtSubtitle;
  final SemanticNode recommendedSubtitle;
  final SemanticNode recentlyAddedSubtitle;

  factory HomeSemantics.fromJson(Map<String, dynamic> json) => HomeSemantics(
        address: SemanticNode.fromJson(
          json['address'] ?? {},
        ),
        searchBarHint: SemanticNode.fromJson(
          json['searchBarHint'] ?? {},
        ),
        promotionSubtitle: SemanticNode.fromJson(
          json['promotionSubtitle'] ?? {},
        ),
        mostBoughtSubtitle: SemanticNode.fromJson(
          json['mostBoughtSubtitle'] ?? {},
        ),
        recommendedSubtitle: SemanticNode.fromJson(
          json['recommendedSubtitle'] ?? {},
        ),
        recentlyAddedSubtitle: SemanticNode.fromJson(
          json['recentlyAddedSubtitle'] ?? {},
        ),
      );

  static Future<HomeSemantics> load() async {
    final jsonSemantics = await AppConfig.loadSemantics(
      'assets/accessibility/home/home_semantics.json',
    );
    return HomeSemantics.fromJson(jsonSemantics);
  }
}
