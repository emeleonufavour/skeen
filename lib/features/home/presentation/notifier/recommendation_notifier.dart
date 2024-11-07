import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/utils/recommendation_service.dart';
import 'package:skeen/features/home/domain/entity/products_entity.dart';
import 'package:skeen/features/skincare_goals/presentation/notifier/skin_goals_notifier.dart';

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

      if (selectedGoals.isNotEmpty) {
        state = _recommendationService.recommendProducts(selectedGoals);
      }
    }
  }
}

final recommendationProvider =
    StateNotifierProvider<RecommendationNotifier, List<Product>>((ref) {
  final skinGoals = ref.watch(skinGoalsNotifier.notifier);
  final recommendationService = RecommendationService();
  return RecommendationNotifier(recommendationService, skinGoals);
});
