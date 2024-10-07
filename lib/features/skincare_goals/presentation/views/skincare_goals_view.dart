import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

class SkincareGoalsView extends ConsumerWidget {
  const SkincareGoalsView({super.key});

  static const String route = '/skincare_goals';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(positionProvider);
    final skinGoals = ref.watch(skinGoalsNotifier);
    final skinGoalsProvider = ref.read(skinGoalsNotifier.notifier);
    final skinGoalProvider = ref.read(setSkinGoalProvider.notifier);

    bool isSkinHealth = position == 0;
    return BaseScaffold(
      padding: EdgeInsets.zero,
      body: Column(
        children: [
          const AppBarWidget(
            title: 'Skin care goals',
          ),
          skinGoals.routines.isEmpty && skinGoals.healthGoal.goals!.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (screenHeight * .4).verticalSpace,
                    const TextWidget(
                      "You are yet to set a goal click the + button",
                      fontWeight: w500,
                      textColor: Palette.text1,
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const GoalTabBar(),
                      20.verticalSpace,
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: isSkinHealth
                            ? skinGoals.visibleList[0].goals!.length
                            : skinGoals.visibleList.length,
                        itemBuilder: (context, index) {
                          final name = isSkinHealth
                              ? skinGoals.visibleList[0].goals![index].name
                              : skinGoals.visibleList[index].routineName!;
                          final frequency = isSkinHealth
                              ? null
                              : skinGoals.visibleList[index].frequency;
                          return SkinGoalListItem(
                            name: name,
                            frequency: frequency,
                            onDelete: isSkinHealth
                                ? () async => skinGoalsProvider
                                    .deleteHealthGoal(index, skinGoalProvider)
                                : () async =>
                                    skinGoalsProvider.deleteRoutine(index),
                          );
                        },
                      ),
                    ],
                  ).padding(horizontal: kGlobalPadding),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => SetYourGoalsBs.show(context),
        child: ImageWidget(url: Assets.add),
      ),
      useSingleScroll: false,
    );
  }
}
