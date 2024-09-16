// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:myskin_flutterbytes/src/features/chat_bot/chat_bot.dart';

// class MockDisappearNotifier extends Mock implements DisappearNotifier {}

// // We'll mock the specific method we need instead of the whole class
// class MockSendMessage extends Mock {
//   Future<MockChatResponse> call(Content content);
// }

// class MockChatBotNotifier extends Mock implements ChatBotNotifier {
//   MockGenerativeModel? model;
//   MockChatSession? chat;
//   @override
//   MockDisappearNotifier disappearNotifier;
//   MockChatBotNotifier(this.disappearNotifier, [this.model, this.chat]);
//   @override
//   ChatBotState state = ChatBotState(messages: [], isLoading: false);
// }

// class MockChatResponse {
//   String text;
//   MockChatResponse(this.text);
// }

// class MockGenerativeModel {
//   String modelType;
//   String apiKey;
//   MockGenerativeModel({required this.modelType, required this.apiKey});
// }

// // Fake implementation of ChatSession
// class MockChatSession {
//   final MockSendMessage mockSendMessage;

//   MockChatSession(this.mockSendMessage);

//   Future<MockChatResponse> sendMessage(String content) =>
//       Future.value(MockChatResponse(content));
// }

// void main() {
//   late MockChatBotNotifier chatBotNotifier;
//   late MockDisappearNotifier mockDisappearNotifier;
//   late MockSendMessage mockSendMessage;

//   setUp(() {
//     mockDisappearNotifier = MockDisappearNotifier();
//     mockSendMessage = MockSendMessage();

//     // Create a fake ChatSession with our mocked sendMessage method
//     final fakeChatSession = MockChatSession(mockSendMessage);

//     chatBotNotifier = MockChatBotNotifier(mockDisappearNotifier);
//     // when(() => chatBotNotifier.disappearNotifier)
//     //     .thenReturn(mockDisappearNotifier);
//     // when(() => mockGenerativeModel.startChat()).thenReturn(mockChatSession);
//     chatBotNotifier.model =
//         MockGenerativeModel(modelType: "modelType", apiKey: "apiKey");
//     chatBotNotifier.chat = fakeChatSession;
//   });

//   test('sendMessage adds user message to state', () async {
//     const String userMessage = 'Hello, Test!';
//     when(() => mockSendMessage(any()))
//         .thenAnswer((_) async => MockChatResponse(userMessage));

//     await chatBotNotifier.sendMessage(userMessage);

//     expect(chatBotNotifier.state.messages.length, equals(2));
//     expect(chatBotNotifier.state.messages[1].text, equals(userMessage));
//     expect(chatBotNotifier.state.messages[1].isServer, isFalse);
//   });

//   test('sendMessage adds AI response to state', () async {
//     const String userMessage = 'Hello, ChatBot!';
//     const String aiResponse = 'Hello, Human!';
//     when(() => mockSendMessage(any()))
//         .thenAnswer((_) async => MockChatResponse(aiResponse));

//     await chatBotNotifier.sendMessage(userMessage);

//     expect(chatBotNotifier.state.messages.length, equals(2));
//     expect(chatBotNotifier.state.messages[0].text, equals(aiResponse));
//     expect(chatBotNotifier.state.messages[0].isServer, isTrue);
//   });

//   test('sendMessage toggles DisappearNotifier for first message', () async {
//     const String userMessage = 'Hello, ChatBot!';
//     when(() => mockSendMessage(any()))
//         .thenAnswer((_) async => MockChatResponse("Hello, Human!"));

//     await chatBotNotifier.sendMessage(userMessage);

//     verify(() => mockDisappearNotifier.toggle()).called(1);
//   });

//   test('sendMessage handles errors', () async {
//     final userMessage = 'Hello, ChatBot!';
//     when(() => mockSendMessage(any())).thenThrow(Exception('API Error'));

//     await chatBotNotifier.sendMessage(userMessage);

//     expect(chatBotNotifier.state.messages.length, equals(1));
//     expect(chatBotNotifier.state.isLoading, isFalse);
//   });
// }
