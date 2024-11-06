import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/cores/utils/recommendation_service.dart';
import 'package:skeen/features/home/domain/entity/products_entity.dart';
import 'package:skeen/features/features.dart';

class RecommendationNotifier extends StateNotifier<List<Product>> {
  final RecommendationService _recommendationService;
  final SkinGoalsNotifier _skinGoalsNotifier;

  RecommendationNotifier(this._recommendationService, this._skinGoalsNotifier)
      : super([]) {
    // Initialize recommendations based on current goals
    _updateRecommendations();

    // Listen to changes in skin goals
    _skinGoalsNotifier.addListener((state) {
      if (state.healthGoal.goals != null) {
        AppLogger.log("goals: ${state.healthGoal.goals}",
            tag: "RecommendationNotifier");
        _updateRecommendations();
      }
    });
  }

  void _updateRecommendations() {
    final goals = _skinGoalsNotifier.state.healthGoal.goals;
    if (goals != null && goals.isNotEmpty) {
      final selectedGoals = goals
          .where((goal) => goal.isSelected)
          .map((goal) => goal.name)
          .toList();
      AppLogger.log(
          "Selected goals: $selectedGoals\nAvailable products: ${allProducts.length}",
          tag: "RecommendationNotifier");

      if (selectedGoals.isNotEmpty) {
        final recommendations =
            _recommendationService.recommendProducts(selectedGoals);
        AppLogger.log("Received ${recommendations.length} recommendations",
            tag: "RecommendationNotifier");
        state = recommendations;
      }
    } else {
      AppLogger.logWarning("Goals is null", tag: "RecommendationNotifier");
    }
  }
}

final recommendationProvider =
    StateNotifierProvider<RecommendationNotifier, List<Product>>((ref) {
  final skinNotifier = ref.watch(skinGoalsNotifier.notifier);
  final recommendationService = RecommendationService();
  return RecommendationNotifier(recommendationService, skinNotifier);
});
