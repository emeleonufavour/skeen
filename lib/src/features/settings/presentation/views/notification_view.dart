import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myskin_flutterbytes/src/cores/cores.dart';

class NotificationView extends ConsumerWidget {
  const NotificationView({super.key});

  final route = "notification_view";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseScaffold(
      body: Column(
        children: [
          Row(
            children: [
              const TextWidget("In-App notification"),
              Switch.adaptive(value: false, onChanged: (v) {})
            ],
          ),
          const TextWidget(
            "Reminders",
            fontWeight: w500,
            textColor: Palette.grey,
          )
        ],
      ),
      useSingleScroll: false,
    );
  }
}
