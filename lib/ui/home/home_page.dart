import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myskin_flutterbytes/ui/home/widgets/activity_box.dart';
import 'package:myskin_flutterbytes/ui/home/widgets/recommendation_box.dart';
import 'package:myskin_flutterbytes/ui/widgets/s_medium_button.dart';
import 'package:myskin_flutterbytes/ui/widgets/s_text_widget.dart';
import 'package:myskin_flutterbytes/utilities/extensions.dart';

import '../style/ui_constants.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIConstants.backgroundColor,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: UIConstants.scaffoldHorizontalPadding),
          child: SizedBox(
            child: Center(
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff98FBF5),
                ),
                child: const Center(
                  child: TextWidget(
                    text: "AN",
                    fontsize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(
              text: "Hello, ",
              fontWeight: FontWeight.w500,
              color: Color(0xff999999),
            ),
            TextWidget(
              text: "Alexa Nurul",
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        actions: [
          Container(
            margin:
                EdgeInsets.only(right: UIConstants.scaffoldHorizontalPadding),
            padding: EdgeInsets.all(10.h),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: UIConstants.borderColor)),
            child: SvgPicture.asset("assets/svg/bell.svg"),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            10.h.sH,
            // Banner
            Container(
              width: 335.w,
              height: 193.h,
              decoration: BoxDecoration(
                  color: const Color(0xffEEDDE0),
                  borderRadius: BorderRadius.all(
                      Radius.circular(UIConstants.borderRadius))),
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
                      child: Image.asset("assets/images/woman.png"))
                ],
              ),
            ),
            //Activities
            Padding(
              padding: EdgeInsets.symmetric(
                      horizontal: UIConstants.scaffoldHorizontalPadding,
                      vertical: UIConstants.verticalPadding)
                  .copyWith(top: 30.h),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Activities
                  TextWidget(
                    text: "Activites",
                    fontsize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  TextWidget(
                    text: "See all",
                    fontsize: 14,
                    color: Color(0xff999999),
                  )
                ],
              ),
            ),
            // Activity
            Padding(
              padding:
                  EdgeInsets.only(left: UIConstants.scaffoldHorizontalPadding),
              child: SizedBox(
                height: 96.h,
                child: ListView(scrollDirection: Axis.horizontal, children: [
                  ActivityBox(
                    iconPath: "assets/svg/lotus.svg",
                  ),
                  ActivityBox(
                    iconPath: "assets/svg/flower.svg",
                  )
                ]),
              ),
            ),
            // Recommended
            Padding(
              padding: EdgeInsets.symmetric(
                      horizontal: UIConstants.scaffoldHorizontalPadding,
                      vertical: UIConstants.verticalPadding)
                  .copyWith(top: 30.h),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Recommended for you
                  TextWidget(
                    text: "Recommended for you",
                    fontsize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  TextWidget(
                    text: "See all",
                    fontsize: 14,
                    color: Color(0xff999999),
                  )
                ],
              ),
            ),
            // Recommendation
            Padding(
              padding:
                  EdgeInsets.only(left: UIConstants.scaffoldHorizontalPadding),
              child: SizedBox(
                height: 319.h,
                child:
                    ListView(scrollDirection: Axis.horizontal, children: const [
                  RecommendationBox(
                      tagColor: Color(0xffE67400),
                      tagName: "Product",
                      imagePath: "assets/images/face_cream.png",
                      title: "Hydrating Face Moisturizer",
                      description:
                          "Deep hydration for dry and sensitive skin. Contains hyaluronic acid and vitamin E."),
                  RecommendationBox(
                      tagColor: Color(0xffDD5380),
                      tagName: "Diet",
                      imagePath: "assets/images/veggies.png",
                      title: "Glowing Skin Diet",
                      description:
                          "Incorporate these superfoods for radiant skin. Expert nutrition tips included.")
                ]),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: SvgPicture.asset("assets/svg/scan_icon.svg"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
