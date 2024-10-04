import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:myskin_flutterbytes/src/cores/utils/session_manager.dart';
import '../../../../cores/shared/toast.dart';
import '../../../../cores/utils/internet_connectivity.dart';
import '../../chat_bot.dart';

final sessionManagerProvider = Provider<SessionManager>((ref) {
  return SessionManager();
});

const String geminiApiKey = String.fromEnvironment('API_KEY');
String introText =
    "Welcome! 👋 I'm here to help with all your skincare needs. You can ask me about your skin test results, get personalized product recommendations, or even scan the barcode of your skincare products to learn more about them. How can I assist you today?";

final chatBotProvider =
    StateNotifierProvider<ChatBotNotifier, ChatBotState>((ref) {
  final disappearNotifier = ref.read(disappearProvider.notifier);
  final sessionManager = ref.read(sessionManagerProvider);
  GenerativeModel model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: geminiApiKey,
  );
  ChatSession chat = model.startChat();

  return ChatBotNotifier(disappearNotifier, model, chat,
      navigatorKey.currentContext!, sessionManager);
});

class ChatBotNotifier extends StateNotifier<ChatBotState> {
  final DisappearNotifier disappearNotifier;
  final GenerativeModel model;
  final ChatSession chat;
  final BuildContext context;
  final SessionManager _sessionManager;

  ChatBotNotifier(this.disappearNotifier, this.model, this.chat, this.context,
      this._sessionManager)
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

  Future<void> sendMessage(String message) async {
    state = state.copyWith(isLoading: true);

    bool hasInternet = await InternetConnectivity.hasConnection();

    if (!hasInternet && context.mounted) {
      showToast(
        context: context,
        message:
            "No internet connection. Please check your connection and try again.",
        type: ToastType.error,
      );
      state = state.copyWith(isLoading: false);
      return;
    }

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
        await _saveChatHistory();
      }
    } catch (e) {
      AppLogger.log(e.toString());
      if (context.mounted) {
        showToast(
          context: context,
          message: "Failed to send message. Please try again.",
          type: ToastType.error,
        );
      }
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
