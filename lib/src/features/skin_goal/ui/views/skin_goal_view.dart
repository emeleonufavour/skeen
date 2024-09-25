import 'package:myskin_flutterbytes/src/features/skin_goal/ui/notifier/skin_goals_notifier.dart';

import '../../skin_goal.dart';
import '../notifier/set_goal_tab_bar_position.dart';

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
    final provider = ref.watch(skinGoalsNotifier);

    bool isSkinHealth = position == 0;

    return Scaffold(
      appBar: const CustomAppBar(title: "Skincare goal"),
      body: provider.routines.isEmpty && provider.healthGoal.goals!.isEmpty
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
                Container(
                  width: tabBarWidth,
                  height: 55.h,
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  decoration: BoxDecoration(
                      color: Palette.primaryColor.withOpacity(0.1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(24))),
                  child: Stack(children: [
                    AnimatedPositioned(
                      left: position,
                      duration: duration,
                      child: Container(
                        width: tabBarWidth / 2,
                        height: 37.h,
                        decoration: const BoxDecoration(
                            color: Palette.primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                              onTap: () {
                                ref.read(positionProvider.notifier).moveLeft();
                                ref
                                    .read(skinGoalsNotifier.notifier)
                                    .showOnlySkinHealthGoals();
                              },
                              child: TextWidget(
                                "Skin health",
                                fontWeight: w500,
                                fontSize: 14.sp,
                                textColor: isSkinHealth
                                    ? Colors.white
                                    : Palette.primaryColor.withOpacity(0.5),
                              )),
                          10.w.horizontalSpace,
                          GestureDetector(
                              onTap: () {
                                ref.read(positionProvider.notifier).moveRight();
                                ref
                                    .read(skinGoalsNotifier.notifier)
                                    .showOnlySkinRoutine();
                              },
                              child: TextWidget(
                                "Routine",
                                fontWeight: w500,
                                fontSize: 14.sp,
                                textColor: !isSkinHealth
                                    ? Colors.white
                                    : Palette.primaryColor.withOpacity(0.5),
                              ))
                        ],
                      ),
                    ),
                  ]),
                ),
                20.h.verticalSpace,
                Expanded(
                  child: ListView.builder(
                      itemCount: isSkinHealth
                          ? provider.visibleList[0].goals!.length
                          : provider.visibleList.length,
                      itemBuilder: (context, index) {
                        if (isSkinHealth) {
                          final name =
                              provider.visibleList[0].goals![index].name;
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.h, horizontal: 15.w),
                            margin: EdgeInsets.only(bottom: 10.h),
                            decoration: BoxDecoration(
                                border: Border.all(color: Palette.lightGrey),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12))),
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
                                const Icon(Icons.more_horiz)
                              ],
                            ),
                          );
                        } else {
                          final name =
                              provider.visibleList[index].category.name;
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.h, horizontal: 15.w),
                            margin: EdgeInsets.only(bottom: 10.h),
                            decoration: BoxDecoration(
                                border: Border.all(color: Palette.lightGrey),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12))),
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
                                const Icon(Icons.more_horiz)
                              ],
                            ),
                          );
                        }
                      }),
                ),
              ],
            ).padding(horizontal: kGlobalPadding),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSkinGoalBottomSheet(context);
          AppLogger.log("Skin health => ${provider.visibleList}");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
