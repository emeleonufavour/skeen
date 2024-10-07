import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/track_product/domain/models/skincare_product.dart';
import 'package:skeen/features/track_product/track_product.dart';

import '../../../domain/entities/expiry_reminder.dart';

bool isDateInFuture(DateTime date) {
  DateTime currentDate = DateTime.now();

  return date.isAfter(currentDate);
}

bool isReminderValid(
  ExpiryReminder? expiryReminder,
  DateTime? targetExpiryDate,
  BuildContext context,
) {
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
          Toast.showErrorToast(
              message: 'Reminder is less than 1 week before the expiry date.');
        }
        break;

      case ExpiryReminder.twoWeeksBefore:
        checkResult = checkDateDifference(targetExpiryDate, 14);
        if (checkResult['isValid']!) {
          res = true;
        } else {
          Toast.showErrorToast(
            message: 'Reminder is less than 2 weeks before the expiry date.',
          );
        }
        break;

      case ExpiryReminder.oneMonthBefore:
        checkResult = checkDateDifference(targetExpiryDate, 30);
        if (checkResult['isValid']!) {
          res = true;
        } else {
          Toast.showErrorToast(
            message: 'Reminder is less than 1 month before the expiry date.',
          );
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
  const AddProductBottomSheet({super.key});

  @override
  ConsumerState<AddProductBottomSheet> createState() =>
      _AddProductBottomSheetState();
}

class _AddProductBottomSheetState extends ConsumerState<AddProductBottomSheet> {
  DateTime? expiryDate;
  ExpiryReminder? expiryReminder;
  late TextEditingController _controller;

  // Add error state variables
  String? productNameError;
  String? expiryDateError;

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

  void validateProductName(String value) {
    if (value.trim().isEmpty) {
      setState(() {
        productNameError = 'Product name is required';
      });
    } else {
      setState(() {
        productNameError = null;
      });
    }
  }

  void validateExpiryDate(DateTime? date) {
    if (date == null) {
      setState(() {
        expiryDateError = 'Expiry date is required';
      });
    } else if (!isDateInFuture(date)) {
      setState(() {
        expiryDateError = 'Expiry date must be in the future';
      });
    } else {
      setState(() {
        expiryDateError = null;
      });
    }
  }

  bool validateAllFields() {
    validateProductName(_controller.text);
    validateExpiryDate(expiryDate);

    return productNameError == null && expiryDateError == null;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<String>(textProvider, (_, newValue) {
      _controller.value = _controller.value.copyWith(
        text: newValue,
        selection: TextSelection.collapsed(offset: newValue.length),
      );
      validateProductName(newValue);
    });

    return GestureDetector(
      onTap: () {
        AppLogger.log("Tapped Add product bm");
        FocusScope.of(context).unfocus();
      },
      child: Column(
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
                        onChanged: (value) {
                          ref.read(textProvider.notifier).state = value;
                          validateProductName(value);
                        },
                        errorText: productNameError,
                      ).padding(bottom: 14.h),
                      TextWidget(
                        "When does this product expire?",
                        fontWeight: w500,
                        fontSize: kfsTiny.sp,
                      ).padding(bottom: 5.h),
                      CalendarDropdown(
                        text: "Expiration date",
                        onDateSelected: (v) {
                          setState(() {
                            expiryDate = v;
                          });
                          validateExpiryDate(v);
                        },
                        errorText: expiryDateError,
                      ).padding(bottom: 14.h),
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
                                ExpiryReminder.fromJson(v),
                                expiryDate,
                                context);
                            if (validReminder) {
                              setState(() {
                                expiryReminder = ExpiryReminder.fromJson(v);
                              });
                            }
                          }
                        },
                        onTapped: (v) {},
                      ),
                      60.h.verticalSpace,
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Button(
                    text: "Save",
                    onTap: () {
                      if (validateAllFields() && expiryReminder != null) {
                        ref.read(skinCareProductProvider.notifier).addProduct(
                              SkinCareProduct(
                                name: _controller.text,
                                expiryDate: expiryDate!,
                                expiryReminder: expiryReminder!,
                              ),
                            );
                        ref.read(textProvider.notifier).state = '';
                        goBack();
                      } else {
                        if (expiryReminder == null) {
                          Toast.showErrorToast(
                            message: 'Please set a reminder',
                          );
                        }
                      }
                    },
                  ),
                ).padding(bottom: 15.h)
              ],
            ),
          ),
        ],
      ).padding(horizontal: 17.w),
    );
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
                  child: const AddProductBottomSheet())));
    },
  );
}
