import '../../auth.dart';

class SigninView extends StatelessWidget {
  SigninView({super.key});
  static const String route = 'sign_in';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthView(
      heading: "Welcome back",
      description: "Log in to continue your personalized skin care journey.",
      contents: [
        TextFieldWidget(textController: emailController, hintText: "Email"),
        PasswordTextfield(
            textController: passwordController, showPasswordStrength: false)
      ],
      mainButtonAction: () {},
      mainButtonText: 'Sign in',
      signUpOrSignIn: true,
    );
  }
}
