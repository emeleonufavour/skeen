import 'package:flutter/cupertino.dart';

import 'package:skeen/cores/cores.dart';

class DailyLogView extends StatelessWidget {
  const DailyLogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.clock,
                size: 40.h,
                color: Colors.grey,
              ),
              10.h.verticalSpace,
              const TextWidget(
                "Hold on we are still working on this ✋",
                textColor: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
