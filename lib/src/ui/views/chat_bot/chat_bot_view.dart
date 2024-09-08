import 'package:myskin_flutterbytes/src/ui/views/chat_bot/text_field.dart';
import 'package:myskin_flutterbytes/src/ui/views/home/home.dart';
import 'package:myskin_flutterbytes/src/ui/widgets/s_app_bar.dart';

String introText =
    "Welcome! 👋 I'm here to help with all your skincare needs. You can ask me about your skin test results, get personalized product recommendations, or even scan the barcode of your skincare products to learn more about them. How can I assist you today?";

class ChatBotView extends StatelessWidget {
  const ChatBotView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
        title: "Welcome",
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: Container(
                padding: EdgeInsets.all(12.h),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: UIConstants.grey.withOpacity(0.2)),
                    shape: BoxShape.circle),
                child: SvgPicture.asset(Assets.svg.arrowClock)),
          ),
        ],
      ),
      body: Column(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 299.w,
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(16)),
            child: TextWidget(
              text: introText,
              fontsize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(child: ListView()),
        const ChatTextField(),
      ]),
    );
  }
}
