import '../views/home/home.dart';

class SDropDown extends StatelessWidget {
  final String? label;
  String hintText;
  final ValueChanged<String?> onChanged;
  bool? tapped;
  String? text;
  List<String> dropDownList;
  final ValueChanged<bool?> onTapped;
  double dropDownHeight;

  SDropDown(
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
                  color: const Color(0xff101828),
                  text: label!,
                  fontWeight: FontWeight.w500,
                  fontsize: 14.sp,
                )
              : const SizedBox.shrink(),
          7.h.sH,
          SmoothCustomDropdown(
              hintText: hintText,
              dropDownList: dropDownList,
              dropDownHeight: dropDownHeight,
              onChanged: onChanged,
              onTapped: onTapped)
        ],
      ),
    );
  }
}

class SmoothCustomDropdown extends StatefulWidget {
  final String hintText;
  final List<String> dropDownList;
  final double dropDownHeight;
  final Function(String) onChanged;
  final Function(bool?) onTapped;
  final bool? tapped;
  final String? initialValue;

  const SmoothCustomDropdown({
    Key? key,
    required this.hintText,
    required this.dropDownList,
    required this.dropDownHeight,
    required this.onChanged,
    required this.onTapped,
    this.tapped,
    this.initialValue,
  }) : super(key: key);

  @override
  _SmoothCustomDropdownState createState() => _SmoothCustomDropdownState();
}

class _SmoothCustomDropdownState extends State<SmoothCustomDropdown> {
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
      duration: const Duration(milliseconds: 300),
      height: _isDropDown ? widget.dropDownHeight + 58.h : 58.h,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffF1F1F1), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            title: TextWidget(
              text: widget.hintText,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontsize: 12.sp,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_selectedText != null)
                  TextWidget(
                    text: _selectedText!,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff999999),
                    fontsize: 12.sp,
                  ),
                AnimatedRotation(
                  turns: _isDropDown ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: UIConstants.grey,
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Divider(
                  height: 1.h, color: UIConstants.grey.withOpacity(0.5)),
            ),
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
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Divider(
                            color: UIConstants.grey.withOpacity(0.2),
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
                              horizontal: 16, vertical: 12),
                          child: TextWidget(
                            text: item,
                            color: const Color(0xff0D0D0D),
                            fontWeight: FontWeight.w500,
                            fontsize: 12.sp,
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
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
