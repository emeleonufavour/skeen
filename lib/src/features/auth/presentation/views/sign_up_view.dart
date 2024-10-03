import 'package:myskin_flutterbytes/src/features/features.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  static const String route = 'sign_up';

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    return AuthView(
      heading: "Create Account",
      description:
          "Sign up for personalized skin care insights and recommendations.",
      contents: [
        TextFieldWidget(
          textController: _fullName,
          hintText: "Full name",
        ),
        TextFieldWidget(
          textController: _email,
          hintText: "Email",
        ),
        TextFieldWidget(
          textController: _password,
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

  late TextEditingController _fullName;
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    _fullName = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _fullName.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}
