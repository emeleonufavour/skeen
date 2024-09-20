// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myskin_flutterbytes/src/features/skin_goal/data/models/skin_goal_state.dart';

class SkinGoalsState {
  List<SkinGoalState> goals = [];
  SkinGoalsState({
    required this.goals,
  });

  SkinGoalsState copyWith({
    List<SkinGoalState>? goals,
  }) {
    return SkinGoalsState(
      goals: goals ?? this.goals,
    );
  }
}
