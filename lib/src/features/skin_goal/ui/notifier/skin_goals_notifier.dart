import 'package:myskin_flutterbytes/src/features/auth/auth.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/data/models/skin_goal_state.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/data/models/skin_goals_state.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/ui/notifier/set_skin_goal_notifier.dart';

import '../../data/models/goal.dart';

class SkinGoalsNotifier extends StateNotifier<SkinGoalsState> {
  SkinGoalsNotifier()
      : super(SkinGoalsState(
            routines: [],
            healthGoal:
                SkinGoalState(category: SkinGoalCategory.health, goals: []),
            visibleList: []));

  addSkinRoutine(SkinGoalState skinRoutine) {
    final newSkinRoutine = [...state.routines, skinRoutine];

    state = state.copyWith(routines: newSkinRoutine);
    showOnlySkinRoutine();
  }

  SkinGoalState updateSkinGoals(List<Goal>? goals) {
    state.healthGoal = state.healthGoal.copyWith(goals: goals);
    showOnlySkinHealthGoals();
    AppLogger.log("Health => ${state.healthGoal}");
    return state.healthGoal;
  }

  List<SkinGoalState> showOnlySkinHealthGoals() {
    state = state.copyWith(visibleList: [state.healthGoal]);
    return state.visibleList;
  }

  List<SkinGoalState> showOnlySkinRoutine() {
    state = state.copyWith(visibleList: state.routines);
    return state.visibleList;
  }
}

final skinGoalsNotifier =
    StateNotifierProvider<SkinGoalsNotifier, SkinGoalsState>((ref) {
  return SkinGoalsNotifier();
});
