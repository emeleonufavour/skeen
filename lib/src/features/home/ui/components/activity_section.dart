import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:myskin_flutterbytes/src/features/auth/auth.dart';
import 'package:myskin_flutterbytes/src/features/chat_bot/ui/views/chat_bot_view.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/ui/notifier/skin_goals_notifier.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/ui/views/skin_goal_view.dart';
import 'dart:developer' as dev;
import '../../../chat_bot/chat_bot.dart';
import '../../data/gemma_response.dart';

Future<GemmaResponse?> pickAndScanImage(
    GenerativeModel model, SkinGoalsNotifier skinGoals) async {
  try {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final res = await _processImage(pickedFile.path, model, skinGoals);
      return res;
    } else {
      print("Image is null");
    }
  } catch (e) {
    dev.log('Error picking or scanning image: $e');
  } finally {
    // setState(() => _isScanning = false);
  }
  return null;
}

Future<GemmaResponse?> _processImage(String imagePath, GenerativeModel model,
    SkinGoalsNotifier skinGoals) async {
  final inputImage = InputImage.fromFilePath(imagePath);
  final List<String> goals = (skinGoals.showOnlySkinHealthGoals())[0]
      .goals!
      .map((goal) => goal.name)
      .toList();
  dev.log("Goals: $goals");
  try {
    File file = File(imagePath);
    final Uint8List bytes = await file.readAsBytes();

    final ByteData byteData = ByteData.sublistView(bytes);
    final content = [
      Content.multi([
        TextPart("""This should be an image of a SkinCare product. 
        The image should contain the ingredients of the product. 
        Try and identify the ingredients of the product. 
        If you are able to identify it, your response should be in JSON format of this structure
        like this only. My skin care goal are ${goals.toString()}.

        {
        "status": "success",
        "code" : 200,
        "ingredients" : [] *This list will contain the list of ingredients in a String form*,
        "suggestion" : "" *Your suggestion on if it will help me achieve my skin goal*
        }

        If the image does not contain an image with a list of ingredients. Your response should be
        like this. 

        {
        "status": "error",
        "code" : 400,
        "ingredients" : [] *This list will contain the list of ingredients in a String form*,
        "suggestion" : "" *Your suggestion on if it will help me achieve my skin goal*
        }

        I am going to use your response directly in my code so make sure it is in JSON format.
        """),
        DataPart('image/jpeg', bytes.buffer.asUint8List()),
      ])
    ];
    var response = await model.generateContent(content);
    var text = response.text;

    if (text == null) {
      dev.log("Omo Gemini no gree pick call o");
    } else {
      String jsonString = text;
      jsonString =
          jsonString.replaceAll('```json', '').replaceAll('```', '').trim();
      // dev.log(jsonString);
      Map<String, dynamic> jsonObject = jsonDecode(jsonString);
      // dev.log(jsonObject);
      // dev.log(.toString());
      return GemmaResponse.fromJson(jsonObject);
    }
  } catch (e) {
    AppLogger.logError(e.toString());
  }
  return Future.value(null);
}

class ActivitySection extends ConsumerStatefulWidget {
  const ActivitySection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ActivitySectionState();
}

class _ActivitySectionState extends ConsumerState<ActivitySection> {
  late final GenerativeModel _model;
  late final ChatSession _chat;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: "",
    );
    _chat = _model.startChat();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SeeAllTile(
          title: 'Activities',
        ),
        SizedBox(
          height: kfs100.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              // Scan skin products
              ActivityBox(
                iconPath: Assets.lotus,
                title: "Scan skin products",
                description:
                    "Scan your product ingredients to know how it affects your skin",
                onTap: () => showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        alignment: Alignment.bottomCenter,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 5.0,
                        backgroundColor: Colors.white,
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Button(
                                onTap: () {},
                                text: "Take a photo ",
                              ),
                              Button(
                                onTap: () async {
                                  final GemmaResponse? response =
                                      await pickAndScanImage(_model,
                                          ref.read(skinGoalsNotifier.notifier));

                                  if (response != null) {
                                    dev.log(response.suggestion);
                                    goTo(ChatBotView.route,
                                        arguments: {"response": response});
                                  } else {
                                    dev.log("Unable to navigate");
                                  }
                                },
                                text: "Choose from library",
                              ),
                              TextWidget(
                                "Cancel",
                                fontWeight: FontWeight.w500,
                                textColor: Colors.red,
                                onTap: () => goBack(),
                              )
                            ].separate(7.h.verticalSpace),
                          ),
                        ),
                      );
                    }),
              ),
              ActivityBox(
                title: "Skincare goal",
                iconPath: Assets.flower,
                description:
                    "You can set personalized skincare goals, track progress, and adjust your routine.",
                onTap: () => goTo(SkinCareGoalView.route),
              )
            ].separate(kfsVeryTiny.horizontalSpace),
          ),
        ),
      ].separate(kfsMedium.verticalSpace),
    );
  }
}
