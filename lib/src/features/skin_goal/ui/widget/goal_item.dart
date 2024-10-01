import '../../skin_goal.dart';

class GoalItem extends StatelessWidget {
  final String goal;
  final bool isSelected;
  final VoidCallback onToggle;

  const GoalItem({
    Key? key,
    required this.goal,
    required this.isSelected,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onToggle,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox.adaptive(
            value: isSelected,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (_) => onToggle(),
          ),
          TextWidget(goal),
        ],
      ),
    );
  }
}
