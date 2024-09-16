import 'package:google_generative_ai/google_generative_ai.dart';
import '../../chat_bot.dart';

const String geminiApiKey = String.fromEnvironment('API_KEY');

final chatBotProvider =
    StateNotifierProvider<ChatBotNotifier, ChatBotState>((ref) {
  final disappearNotifier = ref.read(disappearProvider.notifier);
  GenerativeModel model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: geminiApiKey,
  );
  ChatSession chat = model.startChat();
  return ChatBotNotifier(disappearNotifier, model, chat);
});

class ChatBotNotifier extends StateNotifier<ChatBotState> {
  final DisappearNotifier disappearNotifier;
  final GenerativeModel model;
  final ChatSession chat;
  ChatBotNotifier(this.disappearNotifier, this.model, this.chat)
      : super(ChatBotState(messages: [], isLoading: false));

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
      final response = await chat.sendMessage(Content.text(message));
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
