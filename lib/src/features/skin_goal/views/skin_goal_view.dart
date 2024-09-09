import 'package:myskin_flutterbytes/src/cores/cores.dart';
import '../../../cores/shared/app_bar.dart';
import '../skin_goal.dart';

class SkinCareGoalView extends StatelessWidget {
  const SkinCareGoalView({super.key});

  static const String route = "skin_goal";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Skincare goal"),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: TextWidget(
              "You are yet to set a goal click the + button",
              fontSize: kfsTiny,
              fontWeight: w500,
              decorationColor: Color(0xff999999),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showSkinGoalBottomSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
