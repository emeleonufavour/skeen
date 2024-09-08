import 'package:flutter_svg/svg.dart';

import '../../cores/cores.dart';

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
                    decorationColor: Colors.grey,
                  ),
                  SvgPicture.asset(Assets.scanFont),
                  const TextWidget(
                    " \" button",
                    decorationColor: Colors.grey,
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
