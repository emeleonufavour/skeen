import 'package:myskin_flutterbytes/src/features/features.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});
  static const String route = 'forgot_password';
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthView(
      heading: "Forgot password",
      description:
          "Enter your email address to receive a password verification code.",
      contents: [
        TextFieldWidget(
          textController: emailController,
          hintText: "Email",
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
        ),
      ],
      mainButtonAction: () {},
      mainButtonText: "Submit",
    );
  }
}
