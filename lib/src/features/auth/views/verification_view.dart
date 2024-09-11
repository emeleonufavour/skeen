import 'package:flutter/material.dart';

import '../components/textfield_widget.dart';
import 'auth_view.dart';

class VerificationView extends StatelessWidget {
  VerificationView({super.key});
  static const String route = 'verification';
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthView(
        heading: "Verification",
        description: "Enter the 4-digit code sent to your email to proceed.",
        contents: [
          TextFieldWidget(textController: emailController, hintText: "Email"),
        ],
        mainButtonAction: () {},
        mainButtonText: "Verify",
        signUpOrSignIn: false);
  }
}
