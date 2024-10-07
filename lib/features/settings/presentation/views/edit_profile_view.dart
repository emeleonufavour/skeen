import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';

class EditProfileView extends ConsumerWidget {
  const EditProfileView({super.key});

  static const String route = "edit_profile_view";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseScaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CircleAvatar(),
                  TextFieldWidget(
                    textController: TextEditingController(),
                    hintText: "hintText",
                  ),
                  TextFieldWidget(
                    textController: TextEditingController(),
                    hintText: "hintText",
                  ),
                  TextFieldWidget(
                    textController: TextEditingController(),
                    hintText: 'Password',
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    onSubmit: (_) {},
                    shouldShowPasswordValidator: true,
                  ),
                ].separate(12
                    .h
                    .verticalSpace), // Assuming .separate is from shared package
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0), // Add padding to the button
            child: Button(
              onTap: () {},
              text: "Save",
            ),
          ),
        ],
      ),
      useSingleScroll: false,
    );
  }
}
