import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/settings/presentation/views/app_icon.dart';
import 'package:skeen/features/settings/presentation/views/edit_profile_view.dart';
import 'package:skeen/features/settings/presentation/views/help_view.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  static const route = 'settings_view';
  final name = 'Alexa Nurul';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseScaffold(
      appBar: AppBar(
        title: TextWidget(
          "Settings",
          fontWeight: w600,
          fontSize: 16.sp,
        ),
        centerTitle: true,
        actions: const [
          // Padding(
          //   padding: EdgeInsets.only(right: kfsMedium, top: kfsMedium),
          //   child: TextWidget(
          //     "Logout",
          //     fontWeight: w500,
          //     textColor: Palette.borderColor,
          //   ),
          // )
        ],
      ),
      body: Column(
        children: [
          // Column(
          //   children: [
          //     Container(
          //       padding: EdgeInsets.all(kfsTiny.w),
          //       decoration: const BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: Palette.bg1,
          //       ),
          //       child: TextWidget(
          //         name.initials,
          //         fontWeight: w500,
          //       ),
          //     ),
          //     TextWidget(
          //       name,
          //       fontWeight: w600,
          //       fontSize: 16.sp,
          //     ),
          //     TextWidget(
          //       "Alexanurul1489@gmail.com".toLowerCase(),
          //       fontWeight: w400,
          //       fontSize: 12.sp,
          //       textColor: Palette.text1,
          //     ),
          //     SizedBox(
          //       width: screenWidth / 3.5,
          //       child: Button.smallSized(
          //         onTap: () => goTo(EditProfileView.route),
          //         text: "Edit profile",
          //       ),
          //     ),
          //   ].separate(12.h.verticalSpace),
          // ),
          30.h.verticalSpace,
          // _SettingsOption(
          //   option: "App icon",
          //   iconBackgroundColor: const Color(0xff2BB5F2),
          //   onTap: () => goTo(AppIconScreen.route),
          //   icon: const Icon(
          //     Icons.apps,
          //     color: Palette.white,
          //   ),
          // ),
          _SettingsOption(
            option: "Help and support",
            iconBackgroundColor: const Color(0xffDD5380),
            onTap: () => goTo(HelpSettingsView.route),
            icon: const Icon(
              CupertinoIcons.question_circle,
              color: Palette.white,
            ),
          ),
        ],
      ),
      useSingleScroll: true,
    );
  }
}

class _SettingsOption extends ConsumerWidget {
  final String option;
  final Widget icon;
  final Color iconBackgroundColor;
  final void Function()? onTap;
  const _SettingsOption(
      {required this.option,
      required this.iconBackgroundColor,
      required this.icon,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: iconBackgroundColor,
                child: icon,
              ),
              9.w.horizontalSpace,
              TextWidget(
                option,
                fontWeight: w500,
              )
            ],
          ),
          const Icon(
            CupertinoIcons.forward,
            color: Palette.text1,
          ),
        ],
      ).padding(bottom: 20.h),
    );
  }
}
