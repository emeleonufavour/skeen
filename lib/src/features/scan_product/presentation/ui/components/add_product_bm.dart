import 'package:flutter_svg/svg.dart';
import 'package:myskin_flutterbytes/src/cores/shared/toast.dart';
import 'package:myskin_flutterbytes/src/features/scan_product/scan_product.dart';

bool isDateInFuture(DateTime date) {
  DateTime currentDate = DateTime.now();

  return date.isAfter(currentDate);
}

bool isReminderValid(ExpiryReminder? expiryReminder, DateTime? targetExpiryDate,
    BuildContext context) {
  bool res = false;
  if (expiryReminder != null && targetExpiryDate != null) {
    AppLogger.log("Expiry reminder and Target expiry are not null");
    Map<String, bool> checkResult = {};

    switch (expiryReminder) {
      case ExpiryReminder.oneWeekBefore:
        checkResult = checkDateDifference(targetExpiryDate, 7);
        if (checkResult['isValid']!) {
          res = true;
        } else {
          showToast(
              context: context,
              message: "Reminder is less than 1 week before the expiry date.",
              type: ToastType.error);
        }
        break;

      case ExpiryReminder.twoWeeksBefore:
        checkResult = checkDateDifference(targetExpiryDate, 14);
        if (checkResult['isValid']!) {
          res = true;
        } else {
          showToast(
              context: context,
              message: "Reminder is less than 2 weeks before the expiry date.",
              type: ToastType.error);
        }
        break;

      case ExpiryReminder.oneMonthBefore:
        checkResult = checkDateDifference(targetExpiryDate, 30);
        if (checkResult['isValid']!) {
          res = true;
        } else {
          showToast(
              context: context,
              message: "Reminder is less than 1 month before the expiry date.",
              type: ToastType.error);
        }
        break;
    }
  }
  return res;
}

Map<String, bool> checkDateDifference(DateTime targetDate, int daysDifference) {
  DateTime currentDate = DateTime.now();
  int differenceInDays = targetDate.difference(currentDate).inDays;

  return {
    "isValid": differenceInDays > daysDifference,
  };
}

class AddProductBottomSheet extends ConsumerStatefulWidget {
  AddProductBottomSheet({super.key});

  @override
  _AddProductBottomSheetState createState() => _AddProductBottomSheetState();
}

class _AddProductBottomSheetState extends ConsumerState<AddProductBottomSheet> {
  DateTime? expiryDate;
  ExpiryReminder? expiryReminder;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: ref.read(textProvider));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<String>(textProvider, (_, newValue) {
      _controller.value = _controller.value.copyWith(
        text: newValue,
        selection: TextSelection.collapsed(offset: newValue.length),
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          "Add product",
          fontWeight: w500,
          fontSize: kfsMedium.sp,
        ).padding(vertical: 20.h),
        Expanded(
            child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    "Product name",
                    fontWeight: w500,
                    fontSize: kfsTiny.sp,
                  ).padding(bottom: 5.h),
                  TextFieldWidget(
                    textController: _controller,
                    hintText: "Product name",
                    onChanged: (value) =>
                        ref.read(textProvider.notifier).state = value,
                  ).padding(bottom: 14.h),
                  TextWidget(
                    "When does this product expire?",
                    fontWeight: w500,
                    fontSize: kfsTiny.sp,
                  ).padding(bottom: 5.h),
                  CalendarDropdown(
                      text: "Expiration date",
                      onDateSelected: (v) {
                        expiryDate = v;
                      }).padding(bottom: 14.h),
                  // TextWidget(
                  //   "When did you start using this product?",
                  //   fontWeight: w500,
                  //   fontSize: kfsTiny.sp,
                  // ).padding(bottom: 5.h),
                  // CalendarDropdown(text: "Start date", onDateSelected: (v) {})
                  //     .padding(bottom: 14.h),
                  TextWidget(
                    "When should we remind you before it expires?",
                    fontWeight: w500,
                    fontSize: kfsTiny.sp,
                  ).padding(bottom: 5.h),
                  DropDownWidget(
                      text: "a",
                      dropDownList: [
                        ExpiryReminder.oneWeekBefore.value,
                        ExpiryReminder.twoWeeksBefore.value,
                        ExpiryReminder.oneMonthBefore.value
                      ],
                      hintText: "Set reminder",
                      initialValue: expiryReminder?.value,
                      onChanged: (v) {
                        if (v != null) {
                          bool validReminder = isReminderValid(
                              ExpiryReminder.fromJson(v), expiryDate, context);
                          AppLogger.log("$validReminder", tag: "Product BM");
                          if (validReminder) {
                            expiryReminder = ExpiryReminder.fromJson(v);
                          }
                        }
                      },
                      onTapped: (v) {}),
                  60.h.verticalSpace,
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Button(
                text: "Save",
                onTap: () {
                  if (_controller.text.isNotEmpty &&
                      expiryDate != null &&
                      expiryReminder != null) {
                    ref.read(skinCareProductProvider.notifier).addProduct(
                        SkinCareProduct(
                            name: _controller.text,
                            expiryDate: expiryDate!,
                            expiryReminder: expiryReminder!));
                    ref.read(textProvider.notifier).state = '';
                    goBack();
                  } else {
                    AppLogger.log("show toast", tag: "Add product bm");
                    showToast(
                        context: context,
                        message: "You have not set everything quite right",
                        type: ToastType.error);
                  }
                },
              ),
            ).padding(bottom: 15.h)
          ],
        )),
      ],
    ).padding(horizontal: 17.w);
  }
}

void showAddProductBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(kfsMedium)),
    ),
    builder: (BuildContext context) {
      return LayoutBuilder(
          builder: (context, constraints) => Container(
              constraints: BoxConstraints(
                maxHeight: screenHeight * 0.8,
              ),
              child: SizedBox(
                  height: constraints.maxHeight,
                  child: AddProductBottomSheet())));
    },
  );
}
