import 'package:myskin_flutterbytes/src/features/auth/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myskin_flutterbytes/src/cores/cores.dart';

class NotificationSettingsView extends ConsumerWidget {
  const NotificationSettingsView({super.key});

  static const String route = "notification_view";

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
