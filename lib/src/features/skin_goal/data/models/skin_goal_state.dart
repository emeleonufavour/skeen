// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../skin_goal.dart';
import '../../ui/notifier/set_skin_goal_notifier.dart';
import 'goal.dart';

class SkinGoalState {
  final SkinGoalCategory category;
  final List<Goal>? goals;
  final String? frequency;
  final DateTime? startDate;
  final List<bool>? selectedDays;
  final List<TimeOfDay>? reminderTimes;

  SkinGoalState({
    required this.category,
    this.goals,
    this.frequency,
    this.startDate,
    this.selectedDays,
    this.reminderTimes,
  });

  SkinGoalState copyWith({
    SkinGoalCategory? category,
    List<Goal>? goals,
    String? frequency,
    DateTime? startDate,
    List<bool>? selectedDays,
    List<TimeOfDay>? reminderTimes,
  }) {
    return SkinGoalState(
      category: category ?? this.category,
      goals: goals ?? this.goals,
      frequency: frequency ?? this.frequency,
      startDate: startDate ?? this.startDate,
      selectedDays: selectedDays ?? this.selectedDays,
      reminderTimes: reminderTimes ?? this.reminderTimes,
    );
  }
}
