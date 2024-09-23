import 'package:google_generative_ai/google_generative_ai.dart';
import '../../chat_bot.dart';

const String geminiApiKey = String.fromEnvironment('API_KEY');

final chatBotProvider =
    StateNotifierProvider<ChatBotNotifier, ChatBotState>((ref) {
  final disappearNotifier = ref.read(disappearProvider.notifier);
  return ChatBotNotifier(disappearNotifier);
});

class ChatBotNotifier extends StateNotifier<ChatBotState> {
  final DisappearNotifier disappearNotifier;

  ChatBotNotifier(this.disappearNotifier)
      : super(ChatBotState(messages: [], isLoading: false)) {
    _initializeChat();
  }

  late final GenerativeModel _model;
  late final ChatSession _chat;

  void _initializeChat() {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: geminiApiKey,
    );
    _chat = _model.startChat();
  }

  Future<void> sendMessage(String message) async {
    state = state.copyWith(isLoading: true);
    if (state.messages.isEmpty) {
      disappearNotifier.toggle();
    }

    List<ChatBubble> updatedMessages = [
      ChatBubble(text: message, isServer: false),
      ...state.messages,
    ];
    state = state.copyWith(messages: updatedMessages);

    try {
      final response = await _chat.sendMessage(Content.text(message));
      final text = response.text;
      if (text != null) {
        updatedMessages = [
          ChatBubble(text: text.trim(), isServer: true),
          ...updatedMessages,
        ];
        state = state.copyWith(messages: updatedMessages);
      }
    } catch (e) {
      print(e.toString());
      // Handle error
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
