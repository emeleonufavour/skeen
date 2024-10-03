import 'package:myskin_flutterbytes/src/features/features.dart';

class MedicalHistoryView extends StatelessWidget {
  const MedicalHistoryView({super.key});

  static const String route = '/medical_history';
  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
      body: Column(),
      useSingleScroll: false,
    );
  }
}
