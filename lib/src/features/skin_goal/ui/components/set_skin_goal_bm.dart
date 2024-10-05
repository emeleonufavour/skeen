import 'package:myskin_flutterbytes/src/features/features.dart';

class SkinGoalBottomSheet extends ConsumerWidget {
  final PageController _pageController = PageController();
  SkinGoalBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (int page) {
          ref.read(skinGoalBottomSheetProvider.notifier).setPage(page);
        },
        children: [
          SetSkinGoalView(
            controller: _pageController,
          ),
          SetRoutineReminder(controller: _pageController),
        ],
      ),
    );
  }
}

void showSkinGoalBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(kfsMedium)),
    ),
    builder: (BuildContext context) {
      return LayoutBuilder(
          builder: (context, constraints) => Container(
              constraints: BoxConstraints(
                maxHeight: screenHeight * 0.88,
              ),
              child: SizedBox(
                  height: constraints.maxHeight,
                  child: SkinGoalBottomSheet())));
    },
  );
}
