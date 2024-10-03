import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myskin_flutterbytes/src/cores/shared/shared.dart';

class EditProfileView extends ConsumerWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseScaffold(
      body: Column(
        children: [
          const CircleAvatar(),
          TextFieldWidget(
              textController: TextEditingController(), hintText: "hintText"),
          TextFieldWidget(
              textController: TextEditingController(), hintText: "hintText"),
          TextFieldWidget(
            textController: TextEditingController(),
            isPassword: false,
          ),
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
