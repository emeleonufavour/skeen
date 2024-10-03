import 'package:myskin_flutterbytes/src/features/features.dart';

class SkinCareGoalView extends ConsumerStatefulWidget {
  const SkinCareGoalView({super.key});

  static const String route = "skin_goal";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SkinCareGoalView();
}

class _SkinCareGoalView extends ConsumerState<SkinCareGoalView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final position = ref.watch(positionProvider);
    final skinGoals = ref.watch(skinGoalsNotifier);
    final skinGoalsProvider = ref.read(skinGoalsNotifier.notifier);

    bool isSkinHealth = position == 0;

    return Scaffold(
      appBar: const CustomAppBar(title: "Skincare goal"),
      body: skinGoals.routines.isEmpty && skinGoals.healthGoal.goals!.isEmpty
          ? const Center(
              child: TextWidget(
                "You are yet to set a goal click the + button",
                fontSize: kfsTiny,
                fontWeight: w500,
                textColor: Color(0xff999999),
              ),
            )
          : Column(
              children: [
                const GoalTabBar(),
                20.h.verticalSpace,
                Expanded(
                  child: ListView.builder(
                      itemCount: isSkinHealth
                          ? skinGoals.visibleList[0].goals!.length
                          : skinGoals.visibleList.length,
                      itemBuilder: (context, index) {
                        final name = isSkinHealth
                            ? skinGoals.visibleList[0].goals![index].name
                            : skinGoals.visibleList[index].routineName!;
                        return SkinGoalListItem(
                          name: name,
                          onDelete: isSkinHealth
                              ? () async =>
                                  skinGoalsProvider.deleteHealthGoal(index)
                              : () async =>
                                  skinGoalsProvider.deleteRoutine(index),
                        );
                      }),
                ),
              ],
            ).padding(horizontal: kGlobalPadding),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSkinGoalBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
