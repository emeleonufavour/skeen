import 'package:myskin_flutterbytes/src/cores/cores.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';

class AuthView extends StatelessWidget {
  final String heading;
  final String description;
  final List<Widget> contents;
  final void Function()? mainButtonAction;
  final String mainButtonText;
  final bool signUpOrSignIn;
  const AuthView({
    required this.heading,
    required this.description,
    required this.contents,
    required this.mainButtonAction,
    required this.mainButtonText,
    required this.signUpOrSignIn,
    super.key,
  });

  static const String route = '/sign_up';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              heading,
              fontWeight: w600,
              fontSize: 20.sp,
              textColor: Theme.of(context).primaryColor,
            ).padding(bottom: 7.h),
            TextWidget(
              description,
              fontSize: kfsMedium.sp,
            ).padding(bottom: 30.h),
            Column(
              children: contents.separate(10.h.verticalSpace),
            ).padding(bottom: 60.h),
            Button(
              onTap: mainButtonAction,
              text: mainButtonText,
            ).padding(bottom: 35.h),
            if (signUpOrSignIn)
              Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      const TextWidget(
                        "Or",
                        fontWeight: w500,
                        textColor: Palette.grey,
                      ).padding(horizontal: 20.w),
                      const Expanded(
                        child: Divider(
                          thickness: 2,
                        ),
                      )
                    ],
                  ).padding(bottom: 30.h),

                  // Google
                  Button.withBorderLine(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderColor: Palette.lightGrey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Assets.google).padding(right: 7.w),
                        const TextWidget(
                          "Sign up with Google",
                          textColor: Palette.grey,
                        )
                      ],
                    ),
                  ),
                  // Apple
                  // Button(onTap: () {}),
                ],
              )
          ],
        ).padding(horizontal: kfsMedium),
      ),
    );
  }
}
