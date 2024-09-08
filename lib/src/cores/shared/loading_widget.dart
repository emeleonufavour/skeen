import 'package:myskin_flutterbytes/src/cores/cores.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});
  static Future<void> show(BuildContext context) {
    return showAdaptiveDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: SizedBox(),
    );
  }
}
