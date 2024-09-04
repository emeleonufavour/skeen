import 'package:myskin_flutterbytes/src/ui/home/home.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

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
                  text: "Skin test reports",
                  fontWeight: FontWeight.w600,
                  fontsize: 16.sp,
                ),
              ),
              250.h.sH,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    text: "No skin test yet. Touch the \" ",
                    color: UIConstants.grey,
                  ),
                  SvgPicture.asset(Assets.svg.scanFont),
                  TextWidget(
                    text: " \" button",
                    color: UIConstants.grey,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
