import 'package:myskin_flutterbytes/src/cores/cores.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';

class ChatBotView extends ConsumerWidget {
  ChatBotView({super.key});

  static const String route = "chat_bot";
  final TextEditingController textController = TextEditingController();
  final FocusNode _textFieldFocus = FocusNode();
  final ScrollController _scrollController = ScrollController();

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.easeOutCirc,
      ),
    );
  }

  void _sendMessage(WidgetRef ref) {
    if (textController.text.isNotEmpty) {
      ref.read(chatBotProvider.notifier).sendMessage(textController.text);
      textController.clear();
      _textFieldFocus.unfocus();
      _scrollDown();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatBotState = ref.watch(chatBotProvider);
    final shouldDisappear = ref.watch(disappearProvider);
    return BaseScaffold(
      appBar: CustomAppBar(
        title: "Welcome",
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: Container(
                padding: EdgeInsets.all(kfsVeryTiny.h),
                decoration: BoxDecoration(
                    border: Border.all(color: Palette.borderColor),
                    shape: BoxShape.circle),
                child: SvgPicture.asset(Assets.arrowClock)),
          ),
        ],
      ),
      body: Stack(
        children: [
          AnimatedIntroText(
            hasMoved: shouldDisappear,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 299.w,
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(16)),
                child: const TextWidget(
                  "Welcome! 👋 I'm here to help with all your skincare needs. You can ask me about your skin test results, get personalized product recommendations, or even scan the barcode of your skincare products to learn more about them. How can I assist you today?",
                  fontSize: kfsVeryTiny,
                  fontWeight: w400,
                  textColor: Palette.white,
                ),
              ),
            ),
          ),
          Column(
            children: [
              chatBotState.messages.isEmpty
                  ? ListView().expand()
                  : Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        reverse: true,
                        itemCount: chatBotState.messages.length,
                        itemBuilder: (context, index) {
                          return ChatBubbleWidget(
                            bubble: chatBotState.messages[index],
                          ).padding(bottom: 5.h);
                        },
                      ),
                    ),
              ChatTextField(
                controller: textController,
                focusNode: _textFieldFocus,
                onFieldSubmitted: (v) {
                  _sendMessage(ref);
                  textController.clear();
                },
                sendAction: () {
                  _sendMessage(ref);
                },
              ),
            ],
          ),
        ],
      ),
      useSingleScroll: false,
    );
  }
}
