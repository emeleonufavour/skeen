// // test/chat_bot_test.dart
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:mockito/mockito.dart';
// import 'package:myskin_flutterbytes/src/features/chat_bot/ui/notifier/chat_bot_notifier.dart';

// class MockGenerativeModel extends Mock  {}

// class MockChatSession extends Mock implements ChatSession{}

// void main() {
//   late ChatBotNotifier chatBotNotifier;
//   late MockGenerativeModel mockModel;
//   late MockChatSession mockChat;

//   setUp(() {
//     mockModel = MockGenerativeModel();
//     mockChat = MockChatSession();
//     chatBotNotifier = ChatBotNotifier();
//     chatBotNotifier._model = mockModel;
//     chatBotNotifier._chat = mockChat;
//   });

//   test('Initial state should be empty messages and not loading', () {
//     expect(chatBotNotifier.state.messages, isEmpty);
//     expect(chatBotNotifier.state.isLoading, isFalse);
//   });

//   test('Sending a message should update state correctly', () async {
//     when(mockChat.sendMessage(any))
//         .thenAnswer((_) async => Content.text('Response'));

//     await chatBotNotifier.sendMessage('Hello');

//     expect(chatBotNotifier.state.messages.length, equals(2));
//     expect(chatBotNotifier.state.messages[0].text, equals('Response'));
//     expect(chatBotNotifier.state.messages[0].isServer, isTrue);
//     expect(chatBotNotifier.state.messages[1].text, equals('Hello'));
//     expect(chatBotNotifier.state.messages[1].isServer, isFalse);
//     expect(chatBotNotifier.state.isLoading, isFalse);
//   });

//   test('Sending a message should handle errors', () async {
//     when(mockChat.sendMessage(any)).thenThrow(Exception('API Error'));

//     await chatBotNotifier.sendMessage('Hello');

//     expect(chatBotNotifier.state.messages.length, equals(1));
//     expect(chatBotNotifier.state.messages[0].text, equals('Hello'));
//     expect(chatBotNotifier.state.messages[0].isServer, isFalse);
//     expect(chatBotNotifier.state.isLoading, isFalse);
//   });
// }
