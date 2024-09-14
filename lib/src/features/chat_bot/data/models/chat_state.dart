import '../../chat_bot.dart';

class ChatBotState {
  final List<ChatBubble> messages;
  final bool isLoading;

  ChatBotState({required this.messages, required this.isLoading});

  ChatBotState copyWith({List<ChatBubble>? messages, bool? isLoading}) {
    return ChatBotState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
