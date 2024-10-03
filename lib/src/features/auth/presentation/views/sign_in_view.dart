import 'package:myskin_flutterbytes/src/features/features.dart';

class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key});
  static const String route = 'sign_in';

  @override
  ConsumerState<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  @override
  Widget build(BuildContext context) {
    final signInNotifier = ref.read(signInProvider.notifier);
    return AuthView(
      heading: "Welcome back",
      description: "Log in to continue your personalized skin care journey.",
      contents: [
        TextFieldWidget(
          textController: _email,
          hintText: "Email",
        ),
        TextFieldWidget(
          textController: _password,
          hintText: 'Password',
          isPassword: true,
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () => goTo(ForgotPasswordView.route),
            child: const TextWidget(
              'Forgot Password?',
              fontWeight: w500,
              fontSize: kfsVeryTiny,
              textColor: Palette.primaryColor,
            ),
          ),
        ),
      ],
      mainButtonAction: () => signInNotifier.signIn(
        email: _email.text,
        password: _password.text,
      ),
      mainButtonText: 'Sign in',
      isSignIn: true,
    );
  }

  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }
}
