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

  Map<String, dynamic> toJson() {
    return {
      'messages': messages.map((message) => message.toJson()).toList(),
      'isLoading': isLoading,
    };
  }

  factory ChatBotState.fromJson(Map<String, dynamic> json) {
    return ChatBotState(
      messages: (json['messages'] as List)
          .map((message) => ChatBubble.fromJson(message))
          .toList(),
      isLoading: json['isLoading'],
    );
  }
}
