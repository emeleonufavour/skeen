import 'package:myskin_flutterbytes/src/cores/cores.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';

class ChatBubbleWidget extends StatelessWidget {
  final ChatBubble bubble;
  const ChatBubbleWidget({required this.bubble, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: bubble.isServer ? Alignment.centerLeft : Alignment.centerRight,
      child: AnimatedContainer(
        duration: duration300,
        child: CustomPaint(
          painter: ChatBubblePainter(
              color: bubble.isServer ? Colors.grey : Colors.blue,
              alignment:
                  bubble.isServer ? Alignment.topLeft : Alignment.topRight,
              tail: bubble.tail,
              radius: bubble.text == "" ? 12 : 15,
              text: "",
              context: context),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * .6,
            ),
            margin: bubble.isServer
                ? const EdgeInsets.fromLTRB(40, 7, 17, 7)
                : const EdgeInsets.fromLTRB(17, 7, 40, 7),
            child: ChatMessage(
              text: (bubble.text).isEmpty ? "  " : bubble.text,
              sentAt: "",
              style: TextStyle(
                color: bubble.isServer ? Colors.black : Colors.white,
                fontSize: 14.sp,
                fontFamily: Assets.poppins,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
