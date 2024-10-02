import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:intl/intl.dart' show DateFormat;
import 'package:myskin_flutterbytes/src/cores/shared/toast.dart';
import 'package:myskin_flutterbytes/src/features/chat_bot/chat_bot.dart';

import '../cores.dart';

class CalendarDropdown extends StatefulWidget {
  final String text;
  final DateTime? date;
  final Function(DateTime) onDateSelected;

  const CalendarDropdown({
    super.key,
    required this.text,
    required this.onDateSelected,
    this.date,
  });

  @override
  _CalendarDropdownState createState() => _CalendarDropdownState();
}

class _CalendarDropdownState extends State<CalendarDropdown> {
  bool _isDropDown = false;
  DateTime? _selectedDate;
  Key _calendarKey = UniqueKey();

  void _toggleDropdown() {
    setState(() {
      _isDropDown = !_isDropDown;
      if (_isDropDown) {
        _calendarKey = UniqueKey();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: double.maxFinite,
      duration: const Duration(milliseconds: 500),
      height: _isDropDown ? 350.h + 58.h : 58.h,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffF1F1F1), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: GestureDetector(
              onTap: _toggleDropdown,
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
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_selectedDate != null)
                          TextWidget(
                            DateFormat('MMM d').format(_selectedDate!),
                            textColor: const Color(0xff999999),
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ).padding(right: 5.w),
                        AnimatedRotation(
                          turns: _isDropDown ? 0.5 : 0,
                          duration: const Duration(milliseconds: 300),
                          child: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Color(0xff999999),
                          ),
                        ),
                      ],
                    )
                  ],
                ).padding(horizontal: kfsVeryTiny.w),
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(),
            secondChild: SizedBox(
              height: 350.h,
              child: CalendarCarousel(
                key: _calendarKey,
                onDayPressed: (DateTime date, List events) {
                  if (isDateInFuture(date)) {
                    setState(() {
                      _selectedDate = date;
                      _isDropDown = false;
                    });
                    widget.onDateSelected(date);
                  } else {
                    showToast(
                        context: context,
                        message: "You must pick a day after today",
                        type: ToastType.error);
                  }
                },
                // daysTextStyle: TextStyle(color: ),
                iconColor: Theme.of(context).primaryColor,
                headerTextStyle:
                    TextStyle(color: Colors.black, fontFamily: Assets.poppins),
                selectedDayTextStyle:
                    TextStyle(color: Colors.white, fontFamily: Assets.poppins),
                weekendTextStyle:
                    TextStyle(color: Colors.black, fontFamily: Assets.poppins),
                todayTextStyle:
                    TextStyle(color: Colors.white, fontFamily: Assets.poppins),
                weekdayTextStyle:
                    TextStyle(color: Colors.grey, fontFamily: Assets.poppins),
                thisMonthDayBorderColor: Colors.transparent,
                todayButtonColor: Palette.grey,
                selectedDayButtonColor: Theme.of(context).primaryColor,
                selectedDayBorderColor: Theme.of(context).primaryColor,
                selectedDateTime: _selectedDate ?? DateTime.now(),
                todayBorderColor: Colors.transparent,
                weekFormat: false,
                height: 350.h,

                daysHaveCircularBorder: true,
              ),
            ),
            crossFadeState: _isDropDown
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 500),
          ),
        ],
      ),
    );
  }
}
