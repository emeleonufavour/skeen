import 'package:myskin_flutterbytes/src/features/auth/components/password_textfield.dart';
import 'package:myskin_flutterbytes/src/features/auth/components/textfield_widget.dart';
import 'package:myskin_flutterbytes/src/features/auth/views/auth_view.dart';
import 'package:myskin_flutterbytes/src/features/home/home.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/skin_goal.dart';

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
