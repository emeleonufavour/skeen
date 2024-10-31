// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:skeen/cores/cores.dart';
// import 'package:skeen/features/features.dart';

// class ForgotPasswordView extends ConsumerStatefulWidget {
//   const ForgotPasswordView({super.key});

//   static const String route = 'forgot_password';

//   @override
//   ConsumerState<ForgotPasswordView> createState() => _ForgotPasswordViewState();
// }

// class _ForgotPasswordViewState extends ConsumerState<ForgotPasswordView> {
//   final key = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     final forgotPasswordNotifier = ref.read(forgotPasswordProvider.notifier);

//     StateListener.listen<void>(
//       context: context,
//       provider: forgotPasswordProvider,
//       ref: ref,
//       onSuccess: () => goTo(
//         VerificationView.route,
//         arguments: _email.text,
//       ),
//     );

//     return Form(
//       key: key,
//       child: AuthView(
//         heading: "Forgot password",
//         shouldResize: true,
//         description:
//             "Enter your email address to receive a password verification code.",
//         contents: [
//           TextFieldWidget(
//             textController: _email,
//             keyboardType: TextInputType.emailAddress,
//             hintText: "Email",
//             validator: (v) => v!.validateEmail,
//             textInputAction: TextInputAction.done,
//           ),
//         ],
//         mainButtonAction: () {
//           if (key.currentState?.validate() ?? false) {
//             forgotPasswordNotifier.execute(_email.text);
//           }
//         },
//         mainButtonText: "Submit",
//       ),
//     );
//   }

//   late TextEditingController _email;

//   @override
//   void initState() {
//     _email = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _email.dispose();
//     super.dispose();
//   }
// }
