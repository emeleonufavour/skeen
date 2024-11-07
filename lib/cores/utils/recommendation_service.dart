import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/home/domain/entity/products_entity.dart';

class RecommendationService {
  /// Recommends products based on user goals using a weighted scoring system
  /// [userGoals] is a list of goals the user wants to achieve
  /// [topN] is the number of products to recommend (defaults to 4)
  /// Returns a list of recommended products
  List<Product> recommendProducts(List<String> userGoals, {int topN = 4}) {
    if (userGoals.isEmpty) return [];
    if (topN <= 0) return [];

    // Create case-insensitive mapping of product scores
    final Map<String, String> goalMapping = {};
    if (allProducts.isNotEmpty) {
      for (final goalName in allProducts.first.scores.keys) {
        goalMapping[goalName.toLowerCase()] = goalName;
      }
    }

    // Map user goals to actual score keys
    final validGoals = userGoals
        .where((goal) {
          final normalizedGoal = goal.toLowerCase();
          return goalMapping.containsKey(normalizedGoal);
        })
        .map((goal) => goalMapping[goal.toLowerCase()]!)
        .toList();

    AppLogger.log("Normalized goals: $validGoals",
        tag: "RecommendationService");

    if (validGoals.isEmpty) {
      AppLogger.logWarning(
          "No valid goals found. User goals: $userGoals, Available goals: ${goalMapping.values}",
          tag: "RecommendationService");
      return [];
    }

    // Calculate average score per goal to use as weight
    final Map<String, double> goalWeights = {};
    for (final goal in validGoals) {
      double totalScore = 0;
      for (final product in allProducts) {
        totalScore += product.scores[goal] ?? 0;
      }
      goalWeights[goal] = totalScore / allProducts.length;
    }

    // Calculate weighted scores for each product
    final recommendations = allProducts.map((product) {
      double weightedScore = 0;
      for (final goal in validGoals) {
        final weight = 1 / (goalWeights[goal] ?? 1);
        weightedScore += (product.scores[goal] ?? 0) * weight;
      }

      return MapEntry(product, weightedScore / validGoals.length);
    }).toList();

    // Sort products by weighted score
    recommendations.sort((a, b) => b.value.compareTo(a.value));

    // Log recommendations for debugging
    AppLogger.log(
        "Recommendations: ${recommendations.take(topN).map((e) => '${e.key.name}: ${e.value.toStringAsFixed(2)}').join(', ')}",
        tag: "RecommendationService");

    // Return top N products
    return recommendations.take(topN).map((e) => e.key).toList();
  }
}
