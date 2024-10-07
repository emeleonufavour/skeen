import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:skeen/cores/cores.dart';
import '../../../features.dart';

const String geminiApiKey = String.fromEnvironment('API_KEY');
String introText =
    "Welcome! 👋 I'm here to help with all your skincare needs. How can I assist you today?";

final chatBotProvider =
    StateNotifierProvider<ChatBotNotifier, ChatBotState>((ref) {
  final disappearNotifier = ref.read(disappearProvider.notifier);
  final sessionManager = ref.read(sessionManagerProvider);
  GenerativeModel model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: geminiApiKey,
  );
  ChatSession chat = model.startChat();

  return ChatBotNotifier(disappearNotifier, model, chat, sessionManager);
});

class ChatBotNotifier extends StateNotifier<ChatBotState> {
  final DisappearNotifier disappearNotifier;
  final GenerativeModel model;
  final ChatSession chat;

  final SessionManager _sessionManager;

  ChatBotNotifier(
      this.disappearNotifier, this.model, this.chat, this._sessionManager)
      : super(ChatBotState(messages: [], isLoading: false)) {
    _loadChatHistory();
  }

  String CHAT_HISTORY_KEY = 'chat_history';

  Future<void> _loadChatHistory() async {
    final cachedMessages = _sessionManager.getObjectList<ChatBubble>(
      CHAT_HISTORY_KEY,
      (json) => ChatBubble.fromJson(json),
    );
    if (cachedMessages != null && cachedMessages.isNotEmpty) {
      state = state.copyWith(messages: cachedMessages);
      disappearNotifier.toggle();
    }
  }

  Future<void> _saveChatHistory() async {
    await _sessionManager.storeObjectList<ChatBubble>(
      CHAT_HISTORY_KEY,
      state.messages,
      (obj) => obj.toJson(),
    );
  }

  Future<void> clearChat() async {
    await _sessionManager.deleteStoredBuiltInType(CHAT_HISTORY_KEY);
    state = ChatBotState(messages: [], isLoading: false);
    disappearNotifier.reset();
  }

  Future<void> sendMessage(String message, BuildContext context) async {
    state = state.copyWith(isLoading: true);

    if (state.messages.isEmpty) {
      disappearNotifier.toggle();
    }

    bool hasInternet = await InternetConnectivity.hasConnection();

    if (!hasInternet && context.mounted) {
      Toast.showWarningToast(
        message:
            'No internet connection. Please check your connection and try again.',
      );
      state = state.copyWith(isLoading: false);
      return;
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
        await _saveChatHistory();
      }
    } catch (e) {
      AppLogger.log(e.toString(), tag: "ChatBotNotifier.sendMessage");
      if (context.mounted) {
        Toast.showWarningToast(message: "Failed to deliver message");
      }
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
