import 'package:myskin_flutterbytes/src/features/features.dart';
import 'package:myskin_flutterbytes/src/cores/cores.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  static const String route = 'sign_up';

  final TextEditingController passCtr = TextEditingController();
  final TextEditingController fullNameCtr = TextEditingController();
  final TextEditingController emailCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthView(
      heading: "Create Account",
      description:
          "Sign up for personalized skin care insights and recommendations.",
      contents: [
        TextFieldWidget(
          textController: fullNameCtr,
          hintText: "Full name",
        ),
        TextFieldWidget(
          textController: emailCtr,
          hintText: "Email",
        ),
        TextFieldWidget(
          textController: passCtr,
          hintText: 'Password',
          isPassword: true,
          shouldShowPasswordValidator: true,
        ),
      ],
      mainButtonAction: () {},
      mainButtonText: "Sign up",
      isSignIn: false,
    );
  }
}
