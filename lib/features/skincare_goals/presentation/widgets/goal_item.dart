import 'package:skeen/cores/cores.dart';

class GoalItem extends StatelessWidget {
  final String goal;
  final bool isSelected;
  final VoidCallback onToggle;

  const GoalItem({
    super.key,
    required this.goal,
    required this.isSelected,
    required this.onToggle,
  });

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
