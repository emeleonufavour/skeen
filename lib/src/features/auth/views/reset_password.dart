import 'package:flutter/material.dart';
import 'package:myskin_flutterbytes/src/features/auth/components/password_textfield.dart';
import 'auth_view.dart';

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
          PasswordTextfield(
              textController: passwordController, showPasswordStrength: true)
        ],
        mainButtonAction: () {},
        mainButtonText: "Verify",
        signUpOrSignIn: false);
  }
}
