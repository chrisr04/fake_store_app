import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/accessibility/semantic_node.dart';

class SearchSemantics {
  SearchSemantics({
    required this.searchBarHint,
  });

  final SemanticNode searchBarHint;

  factory SearchSemantics.fromJson(Map<String, dynamic> json) =>
      SearchSemantics(
        searchBarHint: SemanticNode.fromJson(
          json['searchBarHint'] ?? {},
        ),
      );

  static Future<SearchSemantics> load() async {
    final jsonSemantics = await AppConfig.loadSemantics(
      'assets/accessibility/search/search_semantics.json',
    );
    return SearchSemantics.fromJson(jsonSemantics);
  }
}
