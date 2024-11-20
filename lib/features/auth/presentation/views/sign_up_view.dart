import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  static const String route = 'sign_up';

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final key = GlobalKey<FormState>();
  bool _autoValidate = false;

  void _handleSignUp() {
    setState(() => _autoValidate = true);

    if (key.currentState?.validate() ?? false) {
      ref.read(signUpProvider.notifier).signUp(
            email: _email.text.trim(),
            fullName: _fullName.text.trim(),
            password: _password.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final signUpNotifier = ref.read(signUpProvider.notifier);

    StateListener.listen<AuthResultEntity>(
      context: context,
      provider: signUpProvider,
      ref: ref,
      onSuccess: () => clearPath(MedicalHistoryView.route),
    );

    return Form(
      key: key,
      autovalidateMode: _autoValidate
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: AuthView(
        heading: "Create Account",
        description:
            "Sign up for personalized skin care insights and recommendations.",
        contents: [
          TextFieldWidget(
            textController: _fullName,
            hintText: "Full name",
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (v) => v!.validateFullName,
          ),
          TextFieldWidget(
            textController: _email,
            keyboardType: TextInputType.emailAddress,
            hintText: "Email",
            validator: (v) => v!.validateEmail,
            textInputAction: TextInputAction.next,
          ),
          TextFieldWidget(
            textController: _password,
            hintText: 'Password',
            isPassword: true,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            onSubmit: (_) => _handleSignUp(),
            // onSubmit: (_) {
            //   if (key.currentState?.validate() ?? false) {
            //     signUpNotifier.signUp(
            //       email: _email.text,
            //       fullName: _fullName.text,
            //       password: _password.text,
            //     );
            //   }
            // },
            shouldShowPasswordValidator: true,
          ),
        ],
        mainButtonAction: () {
          if (key.currentState?.validate() ?? false) {
            signUpNotifier.signUp(
              email: _email.text,
              fullName: _fullName.text,
              password: _password.text,
            );
          }
        },
        mainButtonText: "Sign up",
        isSignIn: false,
      ),
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
