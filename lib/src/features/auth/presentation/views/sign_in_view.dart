import 'package:myskin_flutterbytes/src/features/features.dart';
import 'package:myskin_flutterbytes/src/cores/cores.dart';

class SignInView extends StatelessWidget {
  SignInView({super.key});
  static const String route = 'sign_in';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthView(
      heading: "Welcome back",
      description: "Log in to continue your personalized skin care journey.",
      contents: [
        TextFieldWidget(
          textController: emailController,
          hintText: "Email",
        ),
        TextFieldWidget(
          textController: passwordController,
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
      mainButtonAction: () {},
      mainButtonText: 'Sign in',
      isSignIn: true,
    );
  }
}
