class SemanticNode {
  SemanticNode({
    required this.label,
    required this.order,
  });

  final String label;

  final double order;

  factory SemanticNode.fromJson(Map<String, dynamic> json) => SemanticNode(
        label: json['label'] ?? '',
        order: json['order'] ?? 0.0,
      );
}
