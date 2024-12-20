import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/cores/shared/app_bar.dart';
import 'package:skeen/features/features.dart';

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

  void _sendMessage(WidgetRef ref, BuildContext context) {
    if (textController.text.isNotEmpty) {
      ref.read(chatBotProvider.notifier).sendMessage(
            textController.text,
            context,
            response,
          );
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
                color: Palette.text1,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const TextWidget("Clear Chat History"),
                    content: const TextWidget(
                        "Are you sure you want to clear all chat history?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const TextWidget("Cancel"),
                      ),
                      FilledButton(
                        onPressed: () {
                          ref.read(chatBotProvider.notifier).clearChat();
                          goBack();
                          Toast.showSuccessToast(
                            message: 'Chat history cleared',
                          );
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.error,
                          foregroundColor: Colors.white,
                        ),
                        child: const TextWidget(
                          'Clear',
                          textColor: Colors.white,
                        ),
                      ),
                      // TextButton(
                      //   onPressed: () {
                      //     ref.read(chatBotProvider.notifier).clearChat();
                      //     Navigator.pop(context);
                      //     Toast.showSuccessToast(
                      //       message: 'Chat history cleared',
                      //     );
                      //   },
                      //   child: const Text("Clear"),
                      // ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          AnimatedIntroText(
            hasMoved: shouldDisappear,
            child: Container(
              width: screenWidth * .8,
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(16)),
              child: TextWidget(
                response == null
                    ? introText
                    : (response!.ingredients.isEmpty
                        ? "The image you gave me does not contain ingredients"
                        : response!.suggestion),
                fontSize: kfsVeryTiny,
                fontWeight: w400,
                textColor: Palette.white,
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
                  _sendMessage(ref, context);
                  textController.clear();
                },
                sendAction: () {
                  _sendMessage(ref, context);
                },
              ),
            ],
          ),
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
                ),
              ),
            ),
        ],
      ).padding(horizontal: kfsExtraLarge),
      padding: EdgeInsets.zero,
      useSingleScroll: false,
    );
  }
}
