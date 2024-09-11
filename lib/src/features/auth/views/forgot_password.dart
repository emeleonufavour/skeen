import 'package:flutter/material.dart';
import 'package:myskin_flutterbytes/src/features/auth/components/textfield_widget.dart';
import 'package:myskin_flutterbytes/src/features/auth/views/auth_view.dart';

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
