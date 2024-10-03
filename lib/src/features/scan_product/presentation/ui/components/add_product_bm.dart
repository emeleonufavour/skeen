import 'package:myskin_flutterbytes/src/features/features.dart';

class AddProductBottomSheet extends ConsumerStatefulWidget {
  const AddProductBottomSheet({super.key});

  @override
  ConsumerState createState() => _AddProductBottomSheetState();
}

class _AddProductBottomSheetState extends ConsumerState<AddProductBottomSheet> {
  DateTime? expiryDate;
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
                    suffixIcon: GestureDetector(
                      onTap: () => goTo(BarcodeScannerScreen.route),
                      child: Container(
                          padding: const EdgeInsets.all(kfsTiny),
                          child: ImageWidget(
                            url: Assets.scanIcon,
                            color: Theme.of(context).primaryColor,
                          )),
                    ),
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
                  TextWidget(
                    "When did you start using this product?",
                    fontWeight: w500,
                    fontSize: kfsTiny.sp,
                  ).padding(bottom: 5.h),
                  CalendarDropdown(text: "Start date", onDateSelected: (v) {})
                      .padding(bottom: 14.h),
                  TextWidget(
                    "Reminder option",
                    fontWeight: w500,
                    fontSize: kfsTiny.sp,
                  ).padding(bottom: 5.h),
                  DropDownWidget(
                      dropDownList: const [
                        "1 week before",
                        "2 weeks before",
                        "1 month before"
                      ],
                      hintText: "Set reminder",
                      onChanged: (v) {},
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
                  if (_controller.text.isNotEmpty && expiryDate != null) {
                    ref.read(skinCareProductProvider.notifier).addProduct(
                        SkinCareProduct(
                            name: _controller.text, expiryDate: expiryDate!));
                    ref.read(textProvider.notifier).state = '';
                    goBack();
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
                  child: const AddProductBottomSheet())));
    },
  );
}
