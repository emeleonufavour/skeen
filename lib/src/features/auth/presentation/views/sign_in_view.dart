import 'package:myskin_flutterbytes/src/features/features.dart';

class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key});
  static const String route = 'sign_in';

  @override
  ConsumerState<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final signInNotifier = ref.read(signInProvider.notifier);

    StateListener.listen<AuthResultEntity>(
      context: context,
      provider: signInProvider,
      ref: ref,
      onSuccess: () => clearPath(MedicalHistoryView.route),
    );

    return Form(
      key: key,
      child: AuthView(
        heading: "Welcome back",
        description: "Log in to continue your personalized skin care journey.",
        contents: [
          TextFieldWidget(
            textController: _email,
            hintText: "Email",
            validator: (v) => v!.validateEmail,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
          ),
          TextFieldWidget(
            textController: _password,
            hintText: 'Password',
            isPassword: true,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            onSubmit: (_) {
              if (key.currentState?.validate() ?? false) {
                signInNotifier.signIn(
                  email: _email.text,
                  password: _password.text,
                );
              }
            },
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
        mainButtonAction: () {
          if (key.currentState?.validate() ?? false) {
            signInNotifier.signIn(
              email: _email.text,
              password: _password.text,
            );
          }
        },
        mainButtonText: 'Sign in',
        isSignIn: true,
      ),
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
