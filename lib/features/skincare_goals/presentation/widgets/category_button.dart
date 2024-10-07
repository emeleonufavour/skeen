import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';

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
      child: AnimatedContainer(
        duration: duration300,
        curve: Curves.fastLinearToSlowEaseIn,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : Palette.text1.withOpacity(0.6),
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
            kSize5.horizontalSpace,
            TextWidget(
              text,
              fontSize: kfsVeryTiny,
              fontWeight: w400,
              textColor:
                  isSelected ? Colors.white : Palette.text1.withOpacity(0.6),
            )
          ],
        ),
      ),
    );
  }
}
