import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:intl/intl.dart' show DateFormat;

import '../cores.dart';

class CalendarDropdown extends StatefulWidget {
  final String text;

  final Function(DateTime) onDateSelected;

  const CalendarDropdown({
    super.key,
    required this.text,
    required this.onDateSelected,
  });

  @override
  State<CalendarDropdown> createState() => _CalendarDropdownState();
}

class _CalendarDropdownState extends State<CalendarDropdown> {
  bool _isDropDown = false;
  DateTime? _selectedDate;
  Key _calendarKey = UniqueKey();

  void _toggleDropdown() {
    setState(() {
      _isDropDown = !_isDropDown;
      if (_isDropDown) {
        // Force calendar to rebuild when opening dropdown
        _calendarKey = UniqueKey();
      }
    });
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
        children: [
          ListTile(
              title: TextWidget(
                widget.text,
                fontWeight: FontWeight.w500,
                textColor: Colors.black,
                fontSize: 12,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_selectedDate != null)
                    TextWidget(
                      DateFormat('MMM d').format(_selectedDate!),
                      textColor: const Color(0xff999999),
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  AnimatedRotation(
                    turns: _isDropDown ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xff999999),
                    ),
                  ),
                ],
              ),
              onTap: _toggleDropdown),
          AnimatedCrossFade(
            firstChild: const SizedBox(),
            secondChild: SizedBox(
              height: 350.h,
              child: CalendarCarousel(
                key: _calendarKey,
                onDayPressed: (DateTime date, List events) {
                  setState(() {
                    _selectedDate = date;
                    _isDropDown = false;
                  });
                  widget.onDateSelected(date);
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
                // todayButtonColor: Palette,
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
