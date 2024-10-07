import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

final routineTextProvider = StateProvider<String>((ref) => '');

class SetSkinGoalView extends ConsumerStatefulWidget {
  final PageController controller;
  const SetSkinGoalView({required this.controller, super.key});

  @override
  ConsumerState<SetSkinGoalView> createState() => _SetSkinGoalViewState();
}

class _SetSkinGoalViewState extends ConsumerState<SetSkinGoalView>
    with SingleTickerProviderStateMixin {
  late TextEditingController _textController;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _textController =
        TextEditingController(text: ref.read(routineTextProvider));
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleCategory(SkinGoalCategory category) {
    ref.read(setSkinGoalProvider.notifier).toggleCategory(category);
    if (category == SkinGoalCategory.health) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(setSkinGoalProvider);

    bool isHealth = provider.category == SkinGoalCategory.health;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isHealth && _animationController.value != 0) {
        _animationController.reverse();
      } else if (!isHealth && _animationController.value != 1) {
        _animationController.forward();
      }
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          "Setting your skincare goal",
          fontSize: kfsMedium.sp,
          fontWeight: w500,
        ).padding(
          vertical: 15.h,
        ),
        Flexible(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextWidget(
                      "Category",
                      fontSize: kfsTiny,
                      fontWeight: w500,
                    ).padding(bottom: 10.h),
                    Row(
                      children: [
                        CategoryButton(
                          text: "Skin health",
                          isSelected: isHealth,
                          onTap: () => _toggleCategory(SkinGoalCategory.health),
                        ),
                        CategoryButton(
                          text: "Routine",
                          isSelected: !isHealth,
                          onTap: () =>
                              _toggleCategory(SkinGoalCategory.routine),
                        ),
                      ].separate(10.w.horizontalSpace),
                    ),
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Stack(
                          children: [
                            Opacity(
                              opacity: isHealth
                                  ? 1 - _animation.value
                                  : _animation.value,
                              child: isHealth
                                  ? const GoalContent()
                                  : RoutineContent(
                                      controller: widget.controller,
                                      textController: _textController,
                                    ),
                            )
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Button(
                  text: "Save",
                  onTap: () {
                    ref
                        .read(setSkinGoalProvider.notifier)
                        .setRoutineName(_textController.text);
                    ref.read(setSkinGoalProvider.notifier).saveGoals();

                    goBack();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ).padding(all: kfsMedium);
  }
}
