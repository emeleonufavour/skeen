// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myskin_flutterbytes/src/features/skin_goal/data/models/skin_goal_state.dart';

class SkinGoalsState {
  List<SkinGoalState> routines;
  SkinGoalState healthGoal;
  List<SkinGoalState> visibleList;

  SkinGoalsState({
    required this.routines,
    required this.healthGoal,
    required this.visibleList,
  });

  SkinGoalsState copyWith({
    List<SkinGoalState>? routines,
    SkinGoalState? healthGoal,
    List<SkinGoalState>? visibleList,
  }) {
    return SkinGoalsState(
      routines: routines ?? this.routines,
      healthGoal: healthGoal ?? this.healthGoal,
      visibleList: visibleList ?? this.visibleList,
    );
  }
}
