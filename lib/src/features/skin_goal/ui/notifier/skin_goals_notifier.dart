import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/data/models/skin_goal_state.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/data/models/skin_goals_state.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/ui/notifier/set_skin_goal_notifier.dart';

class SkinGoalsNotifier extends StateNotifier<SkinGoalsState> {
  SkinGoalsNotifier() : super(SkinGoalsState(goals: []));

  addSkinGoal(SkinGoalState skinGoal) {
    final newSkinGoals = [...state.goals, skinGoal];
    state = state.copyWith(goals: newSkinGoals);
    log("adding");
  }

  List<SkinGoalState> onlySkinGoals() {
    return state.goals
        .where((goal) => goal.category == SkinGoalCategory.health)
        .toList();
  }

  List<SkinGoalState> onlyRoutine() {
    return state.goals
        .where((goal) => goal.category == SkinGoalCategory.routine)
        .toList();
  }
}

final skinGoalsNotifier =
    StateNotifierProvider<SkinGoalsNotifier, SkinGoalsState>((ref) {
  return SkinGoalsNotifier();
});
