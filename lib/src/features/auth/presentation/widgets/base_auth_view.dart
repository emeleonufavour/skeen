import 'package:flutter/gestures.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';

class AuthView extends ConsumerWidget {
  final String heading;
  final String description;
  final List<Widget> contents;
  final void Function()? mainButtonAction;
  final String mainButtonText;
  final bool? isSignIn;

  const AuthView({
    required this.heading,
    required this.description,
    required this.contents,
    required this.mainButtonAction,
    required this.mainButtonText,
    this.isSignIn,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final googleAuthNotifier = ref.read(googleAuthProvider.notifier);

    StateListener.listen<AuthResultEntity>(
      context: context,
      provider: googleAuthProvider,
      ref: ref,
      onSuccess: () => clearPath(MedicalHistoryView.route),
    );

    return BaseScaffold(
      useSingleScroll: false,
      resizeToAvoidInsets: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            heading,
            fontWeight: w600,
            fontSize: kfsExtraLarge,
            textColor: Theme.of(context).primaryColor,
          ),
          kfs8.verticalSpace,
          TextWidget(description),
          kGlobalPadding.verticalSpace,
          ...[
            ...contents,
          ].separate(kfsTiny.verticalSpace),
          if (isSignIn != null) ...[
            kXtremeLarge.verticalSpace,
          ] else ...[
            const Spacer(),
          ],
          Button(
            onTap: mainButtonAction,
            text: mainButtonText,
          ),
          if (isSignIn != null) ...[
            kfs32.verticalSpace,
            const OrWidget(),
            kfs32.verticalSpace,
            Button.withBorderLine(
              onTap: googleAuthNotifier.execute,
              color: Theme.of(context).scaffoldBackgroundColor,
              borderColor: Palette.borderColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Assets.google).padding(right: 7.w),
                  TextWidget(
                    "${isSignIn! ? 'Sign in' : 'Sign up'} with Google",
                    textColor: Palette.text1,
                  )
                ],
              ),
            ),
            const Spacer(),
            Center(
              child: RichTextWidget(
                text: !isSignIn!
                    ? "Already have an account? "
                    : 'Don\'t have an account? ',
                text2: isSignIn! ? "Sign up" : 'Sign in',
                textColor2: Theme.of(context).primaryColor,
                onTap: TapGestureRecognizer()
                  ..onTap = () => !isSignIn!
                      ? goReplace(SignInView.route)
                      : goReplace(SignUpView.route),
                fontWeight2: w600,
                fontWeight: w400,
              ),
            ),
            kXtremeLarge.verticalSpace,
          ] else
            kXtremeLarge.verticalSpace,
        ],
      ),
    );
  }
}
