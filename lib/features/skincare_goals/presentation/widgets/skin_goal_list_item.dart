import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';

final FocusNode buttonFocusNode = FocusNode(debugLabel: 'Menu Button');

class SkinGoalListItem extends ConsumerWidget {
  final String name;
  final String? frequency;
  final void Function() onDelete;
  const SkinGoalListItem({
    required this.name,
    this.frequency,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        border:
            Border.all(color: isDark ? Palette.darkGrey : Palette.borderColor),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                name,
                fontWeight: w500,
                textColor: isDark ? Colors.white : null,
              ),
              7.h.verticalSpace,
              if (frequency != null)
                TextWidget(
                  frequency!,
                  fontWeight: w500,
                  textColor: Palette.text1,
                ),
            ],
          ),
          MenuAnchor(
            childFocusNode: buttonFocusNode,
            style: MenuStyle(
              backgroundColor: WidgetStateProperty.all(Colors.white),
              elevation: const WidgetStatePropertyAll(0),
            ),
            menuChildren: [
              MenuItemButton(
                leadingIcon: const Icon(
                  CupertinoIcons.delete,
                  color: Colors.red,
                ),
                onPressed: onDelete,
                child: const TextWidget(
                  "Delete",
                  fontWeight: w500,
                  textColor: Colors.red,
                ),
              ),
            ],
            builder: (context, controller, _) {
              return IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () {
                  buttonFocusNode.requestFocus();
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
