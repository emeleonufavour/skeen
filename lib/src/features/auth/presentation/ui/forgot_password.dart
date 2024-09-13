import '../../auth.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});
  static const String route = 'forgot_password';
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthView(
        heading: "Forgot password",
        description:
            "Enter your email address to receive a password Verification code.",
        contents: [
          TextFieldWidget(textController: emailController, hintText: "Email"),
        ],
        mainButtonAction: () {},
        mainButtonText: "Submit",
        signUpOrSignIn: false);
  }
}
