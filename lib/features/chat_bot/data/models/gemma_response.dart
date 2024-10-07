class GemmaResponse {
  final String status;
  final int code;
  final List ingredients;
  final String suggestion;
  GemmaResponse({
    required this.status,
    required this.code,
    required this.ingredients,
    required this.suggestion,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status': status,
      'code': code,
      'ingredients': ingredients,
      'suggestion': suggestion,
    };
  }

  factory GemmaResponse.fromJson(Map<String, dynamic> map) {
    return GemmaResponse(
      status: map['status'] as String,
      code: map['code'] as int,
      ingredients: List.from(
        (map['ingredients']),
      ),
      suggestion: map['suggestion'] as String,
    );
  }

  @override
  String toString() {
    return 'GemmaResponse(status: $status, code: $code, ingredients: $ingredients, suggestion: $suggestion)';
  }

  GemmaResponse copyWith({
    String? status,
    int? code,
    List? ingredients,
    String? suggestion,
  }) {
    return GemmaResponse(
      status: status ?? this.status,
      code: code ?? this.code,
      ingredients: ingredients ?? this.ingredients,
      suggestion: suggestion ?? this.suggestion,
    );
  }
}
