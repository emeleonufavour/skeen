import 'package:myskin_flutterbytes/src/features/skin_goal/ui/notifier/skin_goals_notifier.dart';

import '../../skin_goal.dart';

class SkinCareGoalView extends ConsumerWidget {
  const SkinCareGoalView({super.key});

  static const String route = "skin_goal";

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final provider = ref.watch(skinGoalsNotifier);
    return Scaffold(
      appBar: const CustomAppBar(title: "Skincare goal"),
      body: provider.goals.isEmpty
          ? const Center(
              child: TextWidget(
                "You are yet to set a goal click the + button",
                fontSize: kfsTiny,
                fontWeight: w500,
                textColor: Color(0xff999999),
              ),
            )
          : ListView.builder(
              itemCount: provider.goals.length,
              itemBuilder: (context, index) {
                final name = provider.goals[index].category.name;
                return Container(
                  child: TextWidget(name),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showSkinGoalBottomSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
