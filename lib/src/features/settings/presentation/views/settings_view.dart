import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myskin_flutterbytes/src/features/auth/auth.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  final route = 'settings_view';
  final name = 'Alexa Nurul';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseScaffold(
        appBar: AppBar(
          leading: TextWidget(
            "Settings",
            fontWeight: w600,
            fontSize: 16.sp,
          ),
          actions: const [
            TextWidget(
              "Logout",
              fontWeight: w500,
              textColor: Palette.grey,
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(kfsTiny.w),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Palette.bg1,
              ),
              child: TextWidget(
                name.initials,
                fontWeight: w500,
              ),
            ),
            TextWidget(
              name,
              fontWeight: w600,
              fontSize: 16.sp,
            ),
            TextWidget(
              "Alexanurul1489@gmail.com".toLowerCase(),
              fontWeight: w400,
              fontSize: 12.sp,
              textColor: Palette.grey,
            ),
            Button(
              onTap: () {},
              text: "Edit profile",
            ),
            Row(
              children: [
                Row(
                  children: [CircleAvatar(), TextWidget("Notification")],
                ),
                Icon(CupertinoIcons.forward),
              ],
            ),
          ],
        ),
        useSingleScroll: true);
  }
}
