import 'package:flutter_svg/svg.dart';
import 'package:myskin_flutterbytes/src/features/chat_bot/data/models/chat_bubble.dart';
import 'package:myskin_flutterbytes/src/features/chat_bot/ui/components/chat_text_field.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../../../cores/cores.dart';
import '../../../../cores/shared/app_bar.dart';
import '../painter/chat_bubble_painter.dart';
import '../widget/chat_message_widget.dart';

const String _apiKey = String.fromEnvironment('API_KEY');
String introText =
    "Welcome! 👋 I'm here to help with all your skincare needs. You can ask me about your skin test results, get personalized product recommendations, or even scan the barcode of your skincare products to learn more about them. How can I assist you today?";

class ChatBotView extends StatefulWidget {
  const ChatBotView({super.key});

  static const String route = "chat_bot";

  @override
  State<ChatBotView> createState() => _ChatBotViewState();
}

class _ChatBotViewState extends State<ChatBotView> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  TextEditingController textController = TextEditingController();
  late final GenerativeModel _model;
  late final ChatSession _chat;
  final List<({Image? image, String? text, bool fromUser})> _generatedContent =
      <({Image? image, String? text, bool fromUser})>[];
  final FocusNode _textFieldFocus = FocusNode();
  final ScrollController _scrollController = ScrollController();
  bool _loading = false;

  // List<String> _messages = [];
  // void _addMessage(String message) {
  //   setState(() {
  //     _messages.insert(0, message);
  //     _listKey.currentState?.insertItem(0, duration: duration);
  //   });
  // }

  Future<void> _sendChatMessage(String message) async {
    setState(() {
      _loading = true;
    });

    try {
      _generatedContent.insert(0, (image: null, text: message, fromUser: true));
      _listKey.currentState?.insertItem(0, duration: duration);
      final response = await _chat.sendMessage(
        Content.text(message),
      );
      final text = response.text;
      _generatedContent.insert(0, (image: null, text: text, fromUser: false));

      if (text == null) {
        print('No response from API.');
        return;
      } else {
        setState(() {
          _loading = false;
          _scrollDown();
        });
      }
    } catch (e) {
      print(e.toString());
      setState(() {
        _loading = false;
      });
    } finally {
      textController.clear();
      setState(() {
        _loading = false;
      });
      _textFieldFocus.requestFocus();
    }
  }

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: _apiKey,
    );
    _chat = _model.startChat();
  }

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

  Widget _buildItem(BuildContext context, int index,
      Animation<double> animation, ChatBubble bubble) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(animation),
      child: FadeTransition(
        opacity: animation,
        child: Align(
          alignment:
              bubble.isServer ? Alignment.centerLeft : Alignment.centerRight,
          child: AnimatedContainer(
            duration: duration,
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
                  maxWidth: MediaQuery.of(context).size.width * .7,
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
                      fontFamily: Assets.poppins),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(
        title: "Welcome",
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: Container(
                padding: EdgeInsets.all(kfsVeryTiny.h),
                decoration: BoxDecoration(
                    border: Border.all(color: Palette.lightGrey),
                    shape: BoxShape.circle),
                child: SvgPicture.asset(Assets.arrowClock)),
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
              introText,
              fontSize: kfsVeryTiny,
              fontWeight: w400,
              textColor: Palette.white,
            ),
          ),
        ),
        _generatedContent.isEmpty
            ? ListView().expand()
            : Expanded(
                child: AnimatedList(
                  key: _listKey,
                  initialItemCount: _generatedContent.length,
                  itemBuilder: (context, index, animation) => _buildItem(
                      context,
                      index,
                      animation,
                      ChatBubble(
                          isServer: false,
                          text: _generatedContent[index].text!)),
                  reverse: true,
                ),
              ),
        ChatTextField(
            controller: textController,
            focusNode: _textFieldFocus,
            sendAction: () {
              _sendChatMessage(textController.text);
              textController.clear();
            }),
      ]),
      useSingleScroll: false,
    );
  }
}
