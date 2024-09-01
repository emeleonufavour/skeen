import 'package:myskin_flutterbytes/src/ui/home/home.dart';

class HomeBillBoard extends StatelessWidget {
  const HomeBillBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335.w,
      height: 193.h,
      decoration: BoxDecoration(
          color: const Color(0xffEEDDE0),
          borderRadius:
              BorderRadius.all(Radius.circular(UIConstants.borderRadius))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  top: UIConstants.verticalPadding + 10,
                  left: UIConstants.scaffoldHorizontalPadding + 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget(
                    text: "Skin Analyze",
                    fontsize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  9.h.sH,
                  const TextWidget(
                    text: "Find out what your skin says about you",
                  ),
                  22.h.sH,
                  SButton(
                    width: 120.w,
                    label: "Try Now",
                  )
                ],
              ),
            ),
          ),
          // Woman image
          Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(Assets.images.woman.path))
        ],
      ),
    );
  }
}
