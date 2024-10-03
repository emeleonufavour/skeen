import 'package:myskin_flutterbytes/src/cores/cores.dart';

class HelpView extends StatelessWidget {
  const HelpView({super.key});

  final route = "help_view";

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Column(
        children: [
          TextWidget(
            "FAQ",
            fontWeight: w600,
            fontSize: 16.sp,
          )
        ],
      ),
      useSingleScroll: false,
    );
  }
}
