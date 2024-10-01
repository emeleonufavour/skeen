import 'dart:collection';

import '../../model/product.dart';

class RecommendationService {
  List<Product> recommendProducts(List<String> userGoals, {int topN = 4}) {
    final HashMap<Product, int> productScores = HashMap<Product, int>();

    for (final Product product in allProducts) {
      int totalScore = 0;
      for (final String goal in userGoals) {
        totalScore += product.scores[goal] ?? 0;
      }
      productScores[product] = totalScore;
    }

    final List<MapEntry<Product, int>> sortedProducts = productScores.entries
        .toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedProducts.take(topN).map((e) => e.key).toList();
  }
}
