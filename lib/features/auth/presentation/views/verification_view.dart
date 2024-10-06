import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

class VerificationView extends StatelessWidget {
  VerificationView({super.key, required this.mail});
  final String mail;
  static const String route = 'verification';
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthView(
      heading: "Reset Password",
      description: "A reset mail has been sent to $mail ",
      contents: const [
        TextWidget(
          'You\'d be prompted to reset your password, then you can continue to login',
          fontWeight: w500,
        )
      ],
      mainButtonAction: () => clearPath(SignInView.route),
      mainButtonText: "Continue to Login",
    );
  }
}
