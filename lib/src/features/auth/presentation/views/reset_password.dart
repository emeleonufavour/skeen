import 'package:myskin_flutterbytes/src/features/features.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key});
  static const String route = 'reset_password';
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthView(
      heading: "Reset password",
      description:
          "Enter your email address to receive a password Verification code.",
      contents: [
        TextFieldWidget(
          textController: passwordController,
          hintText: 'Password',
          isPassword: true,
        )
      ],
      mainButtonAction: () {},
      mainButtonText: "Verify",
      isSignIn: false,
    );
  }
}
