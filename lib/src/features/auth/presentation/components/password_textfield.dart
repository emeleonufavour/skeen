import 'package:myskin_flutterbytes/src/cores/cores.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';

class PasswordTextfield extends StatefulWidget {
  final TextEditingController textController;
  final bool showPasswordStrength;

  const PasswordTextfield({
    required this.textController,
    required this.showPasswordStrength,
    super.key,
  });

  @override
  State<PasswordTextfield> createState() => _PasswordTextfieldState();
}

class _PasswordTextfieldState extends State<PasswordTextfield> {
  bool _obscureText = false;
  int _passwordNumberCount = 0;

  bool _hasUpperCase = false;

  bool _hasNumber = false;

  bool _hasSpecialChar = false;

  bool _isEightCharacters = false;

  void checkForStrength(String str) {
    _hasUpperCase = RegExp(r'[A-Z]').hasMatch(str);
    _hasNumber = RegExp(r'[0-9]').hasMatch(str);
    _hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(str);
    _isEightCharacters = str.length >= 8;

    setState(() {
      _passwordNumberCount = [
        _hasUpperCase,
        _hasNumber,
        _hasSpecialChar,
        _isEightCharacters
      ].where((element) => element).toList().length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.textController,
          obscureText: _obscureText,
          style: TextStyle(
            fontFamily: Assets.poppins,
            color: Colors.black,
            fontSize: kfsTiny.sp,
          ),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () => setState(() => _obscureText = !_obscureText),
              icon:
                  Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
            hintStyle: TextStyle(
              fontFamily: Assets.poppins,
              color: Palette.hinTextColor,
              fontSize: kfsTiny.sp,
              fontWeight: w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                  width: 2, style: BorderStyle.solid, color: Palette.lightGrey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                  width: 2, style: BorderStyle.solid, color: Palette.lightGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: Theme.of(context).primaryColor),
            ),
            hintText: "Password",
          ),
          onChanged: (value) {
            if (widget.showPasswordStrength) {
              checkForStrength(value);
            }
          },
        ),
        if (widget.showPasswordStrength)
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 10,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Row(
                            children: List.generate(
                              4,
                              (index) => Container(
                                width: 13.w,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                height: 4,
                                decoration: const BoxDecoration(
                                  color: Palette.lightGrey,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: List.generate(
                              _passwordNumberCount,
                              (index) => Container(
                                width: 13.w,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                height: 4,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          if (_passwordNumberCount > 1)
                            Row(
                              children: List.generate(
                                _passwordNumberCount,
                                (index) => Container(
                                  width: 13.w,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  height: 4,
                                  decoration: const BoxDecoration(
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                            ),
                          if (_passwordNumberCount > 2)
                            Row(
                              children: List.generate(
                                _passwordNumberCount,
                                (index) => Container(
                                  width: 13.w,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  height: 4,
                                  decoration: const BoxDecoration(
                                    color: Colors.yellow,
                                  ),
                                ),
                              ),
                            ),
                          if (_passwordNumberCount > 3)
                            Row(
                              children: List.generate(
                                _passwordNumberCount,
                                (index) => Container(
                                  width: 13.w,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  height: 4,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  4.w.horizontalSpace,
                  getStrength(_passwordNumberCount).emoji.isNotEmpty
                      ? Row(
                          children: [
                            Image.asset(
                              getStrength(_passwordNumberCount).emoji,
                              height: 15,
                              width: 15,
                            ),
                            3.w.horizontalSpace,
                            TextWidget(
                              getStrength(_passwordNumberCount).strength,
                            )
                          ],
                        )
                      : const SizedBox()
                ],
              ),
              2.h.verticalSpace,
              Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PasswordStrengthItem(
                        active: _hasUpperCase,
                        title: 'Uppercase character',
                      ),
                      1.h.verticalSpace,
                      PasswordStrengthItem(
                        active: _isEightCharacters,
                        title: '8 characters',
                      ),
                    ],
                  )),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PasswordStrengthItem(
                          active: _hasNumber,
                          title: 'Number',
                        ),
                        1.h.verticalSpace,
                        PasswordStrengthItem(
                          active: _hasSpecialChar,
                          title: 'Special character',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
      ],
    );
  }
}
