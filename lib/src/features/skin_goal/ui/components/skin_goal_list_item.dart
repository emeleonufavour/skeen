import 'package:flutter/cupertino.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';

final FocusNode buttonFocusNode = FocusNode(debugLabel: 'Menu Button');

class SkinGoalListItem extends ConsumerWidget {
  final String name;
  final void Function() onDelete;
  const SkinGoalListItem(
      {required this.name, required this.onDelete, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        border: Border.all(color: Palette.lightGrey),
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
              ),
              7.h.verticalSpace,
              const TextWidget(
                "Everyday, 7:30 AM",
                fontWeight: w500,
                textColor: Palette.grey,
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
