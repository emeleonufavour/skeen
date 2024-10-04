import 'package:flutter_svg/svg.dart';
import 'package:myskin_flutterbytes/src/features/home/data/model/gemma_response.dart';
import '../../../../cores/shared/toast.dart';
import '../../chat_bot.dart';

class ChatBotView extends ConsumerWidget {
  ChatBotView({this.response, super.key});

  final GemmaResponse? response;
  static const String route = "chat_bot";
  final TextEditingController textController = TextEditingController();
  final FocusNode _textFieldFocus = FocusNode();
  final ScrollController _scrollController = ScrollController();

  void _scrollDown() {
    if (_scrollController.hasClients) {
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
            child: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Palette.grey,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Clear Chat History"),
                    content: const Text(
                        "Are you sure you want to clear all chat history?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          ref.read(chatBotProvider.notifier).clearChat();
                          Navigator.pop(context);
                          showToast(
                            context: context,
                            message: "Chat history cleared",
                            type: ToastType.success,
                          );
                        },
                        child: const Text("Clear"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Stack(children: [
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
              child: TextWidget(
                response == null
                    ? introText
                    : (response!.ingredients.isEmpty
                        ? "The image you gave me does not contain ingredients"
                        : "Here is my suggestion ${response!.suggestion}"),
                fontSize: kfsVeryTiny,
                fontWeight: w400,
                textColor: Palette.white,
              ),
            ),
          ),
        ),
        Column(children: [
          chatBotState.messages.isEmpty
              ? ListView().expand()
              : Expanded(
                  child: ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      itemCount: chatBotState.messages.length,
                      itemBuilder: (context, index) {
                        return ChatBubbleWidget(
                                bubble: chatBotState.messages[index])
                            .padding(bottom: 5.h);
                      })),
          ChatTextField(
              controller: textController,
              focusNode: _textFieldFocus,
              onFieldSubmitted: (v) {
                _sendMessage(ref);
                textController.clear();
              },
              sendAction: () {
                _sendMessage(ref);
              }),
        ]),
        if (chatBotState.isLoading)
          Positioned(
            top: 20,
            right: MediaQuery.sizeOf(context).width / 2 - 50,
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle),
                child: const CircularProgressIndicator(
                  strokeWidth: 1,
                  color: Palette.white,
                )),
          ),
      ]),
      useSingleScroll: false,
    );
  }
}
