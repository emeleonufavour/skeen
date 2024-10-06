import 'package:flutter/services.dart';
import 'package:skeen/cores/cores.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController? textController;
  final String? hintText;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool isPassword;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool shouldShowPasswordValidator;
  final void Function(bool)? onPasswordValidityChanged;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmit;

  const TextFieldWidget({
    this.textController,
    this.textInputAction,
    this.onSubmit,
    this.hintText,
    this.onPasswordValidityChanged,
    this.maxLines,
    this.suffixIcon,
    this.onChanged,
    super.key,
    this.validator,
    this.shouldShowPasswordValidator = false,
    this.inputFormatters,
    this.isPassword = false,
    this.keyboardType,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _showPasswordValidator = false;
  late TextEditingController _controller;
  final ValueNotifier<bool> obscureText = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: obscureText,
      builder: (_, value, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              textInputAction: widget.textInputAction,
              controller: widget.textController,
              obscuringCharacter: '●',
              style: TextStyle(
                fontFamily: Assets.poppins,
                fontSize: kfsTiny.sp,
                color: Palette.text2,
              ),
              maxLines: widget.isPassword ? 1 : widget.maxLines,
              obscureText: value && widget.isPassword,
              decoration: InputDecoration(
                suffixIcon: widget.isPassword == true
                    ? suffixWidget(value)
                    : widget.suffixIcon ?? const SizedBox.shrink(),
                hintStyle: TextStyle(
                  fontFamily: Assets.poppins,
                  color: Palette.text1,
                ),
                border: _border,
                enabledBorder: _border,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kfsVeryTiny),
                  borderSide: const BorderSide(
                    style: BorderStyle.solid,
                    color: Palette.primaryColor,
                  ),
                ),
                hintText: widget.hintText,
              ),
              onFieldSubmitted: widget.onSubmit,
              onChanged: (value) {
                if (widget.onChanged != null) widget.onChanged!(value);
                if (widget.isPassword && widget.shouldShowPasswordValidator) {
                  final isValid =
                      _PasswordValidatorWidget.updateValidation(value);
                  if (widget.onPasswordValidityChanged != null) {
                    widget.onPasswordValidityChanged!(isValid);
                  }
                }
              },
              validator: widget.validator ??
                  (widget.isPassword ? _passwordValidator : null),
            ),
            AnimatedSwitcher(
              duration: duration1s,
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              child: _showPasswordValidator
                  ? const _PasswordValidatorWidget()
                  : const SizedBox.shrink(),
            ),
          ],
        );
      },
    );
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (!_PasswordValidatorWidget.isPasswordValid()) {
      return 'Password does not meet all requirements';
    }
    return null;
  }

  OutlineInputBorder get _border {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(kfsVeryTiny),
      borderSide: const BorderSide(
        style: BorderStyle.solid,
        color: Palette.borderColor,
      ),
    );
  }

  Widget suffixWidget(bool value) {
    return GestureDetector(
      onTap: () => obscureText.value = !obscureText.value,
      child: ImageWidget(
        fit: BoxFit.scaleDown,
        url: switch (value) {
          true => Assets.eye,
          false => Assets.eyeClose,
        },
        color: Palette.text1,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.textController ?? TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    if (widget.textController == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    final shouldShow = widget.isPassword && _controller.text.isNotEmpty;
    if (shouldShow != _showPasswordValidator) {
      setState(() {
        _showPasswordValidator = shouldShow;
      });
    }
    if (widget.isPassword) {
      final isValid =
          _PasswordValidatorWidget.updateValidation(_controller.text);
      widget.onPasswordValidityChanged?.call(isValid);
    }
  }
}

class _PasswordValidatorWidget extends StatelessWidget {
  const _PasswordValidatorWidget();

  static final ValueNotifier<List<bool>> _validations =
      ValueNotifier<List<bool>>([false, false, false, false]);

  static bool updateValidation(String password) {
    final newValidations = [
      password.contains(RegExp(r'[A-Z]')),
      password.contains(RegExp(r'[a-z]')),
      password.contains(RegExp(r'[0-9]')),
      password.length >= 8,
    ];
    _validations.value = newValidations;
    return newValidations.every((isValid) => isValid);
  }

  static bool isPasswordValid() {
    return _validations.value.every((isValid) => isValid);
  }

  @override
  Widget build(BuildContext context) {
    final requirements = [
      'At lease 8 characters long',
      'Uppercase',
      'Lowercase',
      'Numbers',
    ];
    return ValueListenableBuilder<List<bool>>(
      valueListenable: _validations,
      builder: (context, validations, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kfs8.verticalSpace,
            const TextWidget(
              'Password Requirements',
              fontWeight: w500,
              fontSize: kfsVeryTiny,
              textColor: Palette.text1,
            ),
            kfs8.verticalSpace,
            Wrap(
              spacing: kMinute,
              runSpacing: kMinute,
              children: List.generate(
                requirements.length,
                (index) => _ChipTile(
                  label: requirements[index],
                  isValid: validations[index],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ChipTile extends StatelessWidget {
  final String label;
  final bool isValid;

  const _ChipTile({
    required this.label,
    required this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration300,
      curve: Curves.fastEaseInToSlowEaseOut,
      padding: EdgeInsets.symmetric(
        horizontal: kfs8.w,
        vertical: kSize5.h,
      ),
      decoration: BoxDecoration(
        color: !isValid
            ? Palette.borderColor2.withOpacity(.05)
            : Palette.bg5.withOpacity(.05),
        border: Border.all(
          color: !isValid ? Palette.borderColor2 : Palette.bg5,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(kMinute.w),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
            label,
            fontSize: kMinute,
            textColor: !isValid ? Palette.borderColor2 : Palette.bg5,
          ),
          kfs8.horizontalSpace,
          ImageWidget(url: !isValid ? Assets.cancel : Assets.check),
        ],
      ),
    );
  }
}
