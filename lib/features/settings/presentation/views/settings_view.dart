import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/home/presentation/notifier/get_user_notifier.dart';
import 'package:skeen/features/settings/presentation/views/app_icon.dart';
import 'package:skeen/features/settings/presentation/views/edit_profile_view.dart';
import 'package:skeen/features/settings/presentation/views/help_view.dart';

import '../../../auth/presentation/notifiers/logout_notifier.dart';
import '../../../auth/presentation/views/sign_in_view.dart';
import '../components/theme_bm.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  static const route = 'settings_view';
  // final name = 'Alexa Nurul';

  @override
  ConsumerState<SettingsView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<SettingsView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userDetailsNotifier.notifier).execute();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = ref.watch(userDetailsNotifier).data;
    final name = userDetails?.fullName?.initials ?? "";
    return BaseScaffold(
      appBar: AppBar(
        title: TextWidget(
          "Settings",
          fontWeight: w600,
          fontSize: 16.sp,
        ),
        centerTitle: true,
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.only(right: kfsMedium, top: kfsMedium),
        //     child: TextWidget(
        //       "Logout",
        //       fontWeight: w500,
        //       textColor: Palette.borderColor,
        //     ),
        //   )
        // ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(kfsTiny.w),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Palette.bg1,
                ),
                child: TextWidget(
                  name,
                  fontWeight: w500,
                ),
              ),
              TextWidget(
                name,
                fontWeight: w600,
                fontSize: 16.sp,
              ),
              TextWidget(
                userDetails?.email?.toLowerCase() ?? "",
                fontWeight: w400,
                fontSize: 12.sp,
                textColor: Palette.text1,
              ),
              SizedBox(
                width: screenWidth / 3.5,
                child: Button.smallSized(
                  onTap: () => goTo(EditProfileView.route),
                  text: "Edit profile",
                ),
              ),
            ].separate(12.h.verticalSpace),
          ),
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
              option: "Change theme",
              iconBackgroundColor: const Color(0xffDD5380),
              icon: const Icon(Icons.brightness_3_rounded),
              onTap: () => showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(kfsMedium)),
                  ),
                  builder: (context) {
                    return LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Container(
                            constraints:
                                BoxConstraints(maxHeight: screenHeight * 0.25),
                            child: const ThemeSelectionBottomSheet());
                      },
                    );
                  })),
          _SettingsOption(
            option: "Help and support",
            iconBackgroundColor: const Color(0xffDD5380),
            onTap: () => goTo(HelpSettingsView.route),
            icon: const Icon(
              CupertinoIcons.question_circle,
              color: Palette.white,
            ),
          ),
          (screenHeight * .22).h.verticalSpace,
          const LogoutButton(),
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

class LogoutButton extends ConsumerWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(
      logoutProvider,
      (_, state) {
        state.whenOrNull(
          error: (error, _) {
            Toast.showErrorToast(message: error.toString());
          },
          data: (_) {
            clearPath(SignInView.route);
          },
        );
      },
    );

    final isLoading = ref.watch(logoutProvider).isLoading;

    return Button(
        text: "Sign out",
        height: 50.h,
        width: 150.w,
        color: Colors.red,
        onTap: isLoading ? null : _showLogoutDialog(context, ref));
  }

  VoidCallback _showLogoutDialog(BuildContext context, WidgetRef ref) {
    return () {
      showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const TextWidget('Sign out'),
          content: const TextWidget('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => goBack(),
              child: const TextWidget('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                goBack();
                ref.read(logoutProvider.notifier).logout();
                Toast.showSuccessToast(
                  message: 'Signed out successfully',
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Colors.white,
              ),
              child: const TextWidget(
                'Sign out',
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    };
  }
}
