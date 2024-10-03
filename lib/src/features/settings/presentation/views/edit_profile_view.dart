import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myskin_flutterbytes/src/features/auth/auth.dart';

class EditProfileView extends ConsumerWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseScaffold(
      body: Column(
        children: [
          CircleAvatar(),
          TextFieldWidget(
              textController: TextEditingController(), hintText: "hintText"),
          TextFieldWidget(
              textController: TextEditingController(), hintText: "hintText"),
          PasswordTextfield(
              textController: TextEditingController(),
              showPasswordStrength: false),
          Button(
            onTap: () {},
            text: "Save",
          )
        ],
      ),
      useSingleScroll: false,
    );
  }
}
