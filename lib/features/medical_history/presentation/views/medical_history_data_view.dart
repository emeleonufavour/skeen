import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

class MedicalInfoView extends ConsumerWidget {
  const MedicalInfoView({super.key});

  static const String route = '/medical_info_view';

  static final ValueNotifier<int> _currentQuestionIndex = ValueNotifier(0);

  static final List<ValueNotifier<String>> _selectedOptions = List.generate(
    MedicalHistoryNotifier.totalQuestions,
    (index) => ValueNotifier<String>(''),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(medicalHistoryProvider);
    final notifier = ref.read(medicalHistoryProvider.notifier);

    StateListener.listen<Map<int, String>>(
      context: context,
      provider: medicalHistoryProvider,
      ref: ref,
      onSuccess: () => clearPath(NavBarView.route),
    );

    return BaseScaffold(
      safeAreaTop: false,
      body: ValueListenableBuilder<int>(
        valueListenable: _currentQuestionIndex,
        builder: (context, selectedIndex, _) {
          return Column(
            children: [
              kXtremeLarge.verticalSpace,
              MedicalTracker(currentIndex: selectedIndex),
              kXtremeLarge.verticalSpace,
              _Questions(
                selectedOptionNotifier: _selectedOptions[selectedIndex],
                question: switch (selectedIndex) {
                  0 =>
                    'Do you have any existing skin conditions (e.g. acne, eczema)?',
                  1 => 'Have you noticed recent changes in your skin?',
                  2 => 'Are you using any skincare products or medications?',
                  3 => 'Do you have allergies to skincare ingredients?',
                  4 => 'Is there a family history of skin conditions?',
                  _ => '',
                },
                selectedOption: (value) =>
                    notifier.setResponse(selectedIndex, value),
                showNeutralOption: selectedIndex == 2,
              ),
              const Spacer(),
              Row(
                children: [
                  Button.withBorderLine(
                    text: 'Back',
                    onTap: switch (selectedIndex) {
                      0 => () {
                          notifier.reset();
                          goBack();
                        },
                      _ => () => _currentQuestionIndex.value--
                    },
                  ).expand(),
                  kfsVeryTiny.horizontalSpace,
                  Button(
                    onTap: notifier.canMoveNext(selectedIndex)
                        ? () {
                            if (notifier.isCompleted()) {
                              notifier.uploadMedicalHistory();
                            } else {
                              _currentQuestionIndex.value++;
                            }
                          }
                        : () {
                            Toast.showWarningToast(
                              message:
                                  'Select an answer to move to the next question',
                            );
                          },
                    text: 'Continue',
                  ).expand(),
                ],
              ),
              (screenHeight * .1).verticalSpace,
            ],
          );
        },
      ),
      useSingleScroll: false,
    );
  }
}

class _Questions extends StatelessWidget {
  const _Questions({
    required this.question,
    required this.selectedOption,
    required this.selectedOptionNotifier,
    this.showNeutralOption = false,
  });

  final String question;
  final ValueChanged<String> selectedOption;
  final ValueNotifier<String> selectedOptionNotifier;
  final bool showNeutralOption;

  @override
  Widget build(BuildContext context) {
    final options = ['Yes', 'No', if (showNeutralOption) 'I don\'t know'];

    return ValueListenableBuilder<String>(
      valueListenable: selectedOptionNotifier,
      builder: (context, selectedString, __) {
        return Column(
          children: [
            TextWidget(
              question,
              fontWeight: w500,
              fontSize: kfsMedium,
            ),
            kGlobalPadding.verticalSpace,
            ...options
                .map(
                  (_) {
                    final isSelected = selectedString == _;
                    return GestureDetector(
                      onTap: () {
                        selectedOptionNotifier.value =
                            _; // Update the ValueNotifier
                        selectedOption.call(_);
                      },
                      child: AnimatedContainer(
                        padding: EdgeInsets.symmetric(
                          horizontal: kfsTiny.w,
                          vertical: kfsMedium.h,
                        ),
                        duration: duration300,
                        curve: Curves.fastLinearToSlowEaseIn,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kfsMedium.w),
                          color: isSelected
                              ? Palette.primaryColor.withOpacity(.25)
                              : Palette.primaryColor.withOpacity(.05),
                        ),
                        child: Row(
                          children: [
                            ImageWidget(
                              url: isSelected
                                  ? Assets.checkSelected
                                  : Assets.checkUnSelected,
                            ),
                            kfsMedium.horizontalSpace,
                            TextWidget(
                              _,
                              fontWeight: w500,
                              fontSize: kfsMedium,
                              textColor: isSelected
                                  ? Palette.primaryColor
                                  : Palette.black,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
                .toList()
                .separate(kfsVeryTiny.verticalSpace),
          ],
        );
      },
    );
  }
}
