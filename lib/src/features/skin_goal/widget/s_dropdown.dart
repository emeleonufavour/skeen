import '../../../cores/cores.dart';

class SDropDown extends StatelessWidget {
  final String? label;
  final String hintText;
  final ValueChanged<String?> onChanged;
  final bool? tapped;
  final String? text;
  final List<String> dropDownList;
  final ValueChanged<bool?> onTapped;
  final double dropDownHeight;

  const SDropDown(
      {this.label,
      required this.dropDownList,
      required this.hintText,
      required this.dropDownHeight,
      required this.onChanged,
      required this.onTapped,
      this.tapped,
      this.text,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0).copyWith(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label != null
              ? TextWidget(
                  decorationColor: const Color(0xff101828),
                  label!,
                  fontWeight: w500,
                  fontSize: kfsTiny.sp,
                )
              : const SizedBox.shrink(),
          CustomDropdown(
              hintText: hintText,
              dropDownList: dropDownList,
              dropDownHeight: dropDownHeight,
              onChanged: onChanged,
              onTapped: onTapped)
        ].separate(7.h.verticalSpace),
      ),
    );
  }
}

class CustomDropdown extends StatefulWidget {
  final String hintText;
  final List<String> dropDownList;
  final double dropDownHeight;
  final Function(String) onChanged;
  final Function(bool?) onTapped;
  final bool? tapped;
  final String? initialValue;

  const CustomDropdown({
    super.key,
    required this.hintText,
    required this.dropDownList,
    required this.dropDownHeight,
    required this.onChanged,
    required this.onTapped,
    this.tapped,
    this.initialValue,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool _isDropDown = false;
  String? _selectedText;

  @override
  void initState() {
    super.initState();
    _selectedText = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: double.maxFinite,
      duration: duration,
      height: _isDropDown ? widget.dropDownHeight + 58.h : 58.h,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffF1F1F1), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            title: TextWidget(
              widget.hintText,
              fontWeight: FontWeight.w500,
              decorationColor: Colors.black,
              fontSize: 12.sp,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_selectedText != null)
                  TextWidget(
                    _selectedText!,
                    fontWeight: FontWeight.w500,
                    decorationColor: const Color(0xff999999),
                    fontSize: 12.sp,
                  ),
                AnimatedRotation(
                  turns: _isDropDown ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Palette.text1,
                  ),
                ),
              ],
            ),
            onTap: () {
              setState(() {
                _isDropDown = !_isDropDown;
              });
              widget.onTapped(_isDropDown);
            },
          ),
          if (_isDropDown)
            Divider(height: 1.h, color: Colors.grey.withOpacity(0.5))
                .padding(horizontal: kfsTiny.w),
          AnimatedCrossFade(
            firstChild: const SizedBox(),
            secondChild: SizedBox(
              height: widget.dropDownHeight,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    widget.dropDownList.length * 2 - 1,
                    (index) {
                      if (index.isOdd) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: kfsTiny.w),
                          child: Divider(
                            color: Colors.grey.withOpacity(0.2),
                            thickness: 1,
                            height: 1,
                          ),
                        );
                      }
                      final itemIndex = index ~/ 2;
                      final item = widget.dropDownList[itemIndex];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedText = item;
                            _isDropDown = false;
                          });
                          widget.onTapped(false);
                          widget.onChanged(item);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: kfsMedium, vertical: kfsVeryTiny),
                          child: TextWidget(
                            item,
                            decorationColor: const Color(0xff0D0D0D),
                            fontWeight: w500,
                            fontSize: kfsVeryTiny.sp,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            crossFadeState: _isDropDown
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: duration,
          ),
        ],
      ),
    );
  }
}
