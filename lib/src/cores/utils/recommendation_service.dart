import 'package:myskin_flutterbytes/src/model/product.dart';

class RecommendationService {
  List<Product> recommendProducts(List<String> userGoals, {int topN = 4}) {
    if (userGoals.isEmpty || allProducts.isEmpty) {
      return [];
    }

    final goalSet = Set<String>.from(userGoals);

    final scoredProducts = allProducts
        .map((product) {
          final score = _calculateScore(product, goalSet);
          return _ScoredProduct(product, score);
        })
        .where((scoredProduct) => scoredProduct.score > 0)
        .toList();

    scoredProducts.sort((a, b) => b.score.compareTo(a.score));

    return scoredProducts.take(topN).map((sp) => sp.product).toList();
  }

  int _calculateScore(Product product, Set<String> goals) {
    return goals.fold<int>(0, (sum, goal) => sum + (product.scores[goal] ?? 0));
  }
}

class _ScoredProduct {
  final Product product;
  final int score;

  _ScoredProduct(this.product, this.score);
}
