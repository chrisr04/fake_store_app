import 'package:fake_store_app/core/core.dart';
import 'package:fake_store_app/accessibility/semantic_node.dart';

class LoginSemantics {
  LoginSemantics({
    required this.logInTitle,
  });

  final SemanticNode logInTitle;

  factory LoginSemantics.fromJson(Map<String, dynamic> json) => LoginSemantics(
        logInTitle: SemanticNode.fromJson(
          json['logInTitle'] ?? {},
        ),
      );

  static Future<LoginSemantics> load() async {
    final jsonSemantics = await AppConfig.loadSemantics(
      'assets/accessibility/auth/login_semantics.json',
    );
    return LoginSemantics.fromJson(jsonSemantics);
  }
}
