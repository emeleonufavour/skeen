import 'package:myskin_flutterbytes/src/cores/cores.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  static String route = "report";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 10.h, left: 17.w),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextWidget(
                  "Skin test reports",
                  fontWeight: w600,
                  fontSize: 16.sp,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextWidget(
                    "No skin test yet. Touch the \" ",
                    textColor: Palette.text1,
                  ),
                  ImageWidget(url: Assets.scanFont),
                  const TextWidget(
                    " \" button",
                    textColor: Palette.text1,
                  ),
                ],
              )
            ].separate(250.h.verticalSpace),
          ),
        ),
      ),
    );
  }
}
