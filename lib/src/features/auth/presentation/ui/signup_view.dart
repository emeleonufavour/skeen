import '../../auth.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  static const String route = 'signup';

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
          ).padding(bottom: 10.h),
          TextFieldWidget(textController: emailCtr, hintText: "Email")
              .padding(bottom: 10.h),
          PasswordTextfield(
            textController: passCtr,
            showPasswordStrength: false,
          )
        ],
        mainButtonAction: () {},
        mainButtonText: "Sign up",
        signUpOrSignIn: true);
  }
}
