import '../../skin_goal.dart';

class CategoryButton extends ConsumerWidget {
  final bool isSelected;
  final void Function()? onTap;
  final String text;
  const CategoryButton(
      {required this.isSelected, required this.text, this.onTap, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          border: Border.all(
            color:
                isSelected ? Colors.transparent : Palette.grey.withOpacity(0.6),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            if (isSelected)
              const Icon(
                Icons.check,
                size: kfsVeryTiny,
                color: Colors.white,
              ),
            TextWidget(
              text,
              fontSize: kfsVeryTiny,
              fontWeight: w400,
              textColor:
                  isSelected ? Colors.white : Palette.grey.withOpacity(0.6),
            )
          ],
        ),
      ),
    );
  }
}
