import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/accessibility/semantic_node.dart';

class RegisterSemantics {
  RegisterSemantics({
    required this.signUpTitle,
  });

  final SemanticNode signUpTitle;

  factory RegisterSemantics.fromJson(Map<String, dynamic> json) =>
      RegisterSemantics(
        signUpTitle: SemanticNode.fromJson(
          json['signUpTitle'] ?? {},
        ),
      );

  static Future<RegisterSemantics> load() async {
    final jsonSemantics = await AppConfig.loadSemantics(
      'assets/accessibility/auth/register_semantics.json',
    );
    return RegisterSemantics.fromJson(jsonSemantics);
  }
}
