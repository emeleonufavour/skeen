import '../../../../cores/cores.dart';

class FAQComponent extends StatelessWidget {
  final String text;
  final String content;

  const FAQComponent({required this.text, required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0).copyWith(bottom: 10),
        child: _CustomDropdown(
          text: text,
          content: content,
        ));
  }
}

class _CustomDropdown extends StatefulWidget {
  final String text;
  final String content;

  const _CustomDropdown({
    required this.text,
    required this.content,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<_CustomDropdown> {
  bool _isDropDown = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: double.maxFinite,
      duration: duration,
      child: Column(
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isDropDown = !_isDropDown;
                });
              },
              child: SizedBox(
                  height: 54.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        widget.text,
                        fontWeight: FontWeight.w500,
                        textColor: Colors.black,
                        fontSize: 12.sp,
                      ),
                      //trailing
                      AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: RotationTransition(
                                turns: animation,
                                child: child,
                              ),
                            );
                          },
                          child: Icon(_isDropDown ? Icons.remove : Icons.add)),
                    ],
                  )),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(),
            secondChild: TextWidget(widget.content),
            crossFadeState: _isDropDown
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: duration,
          )
        ],
      ).padding(horizontal: kfsVeryTiny.w),
    );
  }
}
