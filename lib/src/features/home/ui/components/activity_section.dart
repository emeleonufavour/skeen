import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:myskin_flutterbytes/src/cores/shared/toast.dart';
import 'package:myskin_flutterbytes/src/features/auth/auth.dart';
import 'package:myskin_flutterbytes/src/features/chat_bot/ui/views/chat_bot_view.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/data/models/skin_goals_state.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/ui/notifier/skin_goals_notifier.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/ui/views/skin_goals_view.dart';
import '../../../chat_bot/chat_bot.dart';
import '../../../scan_product/presentation/ui/views/scan_product_view.dart';
import '../../data/gemma_response.dart';

Future<GemmaResponse?> pickAndScanImage(
    GenerativeModel model, SkinGoalsState skinGoals) async {
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
    AppLogger.log('Error picking or scanning image: $e');
  } finally {
    // setState(() => _isScanning = false);
  }
  return null;
}

Future<GemmaResponse?> _processImage(
    String imagePath, GenerativeModel model, SkinGoalsState skinGoals) async {
  final inputImage = InputImage.fromFilePath(imagePath);
  final List<String> goals =
      (skinGoals.healthGoal).goals!.map((goal) => goal.name).toList();
  AppLogger.log("Goals: $goals");
  try {
    File file = File(imagePath);
    final Uint8List bytes = await file.readAsBytes();

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
      AppLogger.log("Omo Gemini no gree pick call o");
    } else {
      String jsonString = text;
      jsonString =
          jsonString.replaceAll('```json', '').replaceAll('```', '').trim();

      Map<String, dynamic> jsonObject = jsonDecode(jsonString);

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
      apiKey: "AIzaSyC9DFSUt3umhF79YEs1UeY4gNqXuIBVHbE",
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
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        elevation: 5.0,
                        backgroundColor: Colors.white,
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Button.withBorderLine(
                                onTap: () {},
                                text: "Take a photo ",
                                color: Colors.transparent,
                                borderColor: Theme.of(context).primaryColor,
                                textColor: Theme.of(context).primaryColor,
                              ),
                              Button.withBorderLine(
                                onTap: () async {
                                  final GemmaResponse? response =
                                      await pickAndScanImage(
                                          _model, ref.read(skinGoalsNotifier));

                                  if (response != null) {
                                    AppLogger.log(response.suggestion);
                                    goTo(
                                      ChatBotView.route,
                                      arguments: response,
                                    );
                                  } else {
                                    AppLogger.log("Unable to navigate");
                                  }
                                },
                                text: "Choose from library",
                                color: Colors.transparent,
                                borderColor: Theme.of(context).primaryColor,
                                textColor: Theme.of(context).primaryColor,
                              ),
                              2.h.verticalSpace,
                              TextWidget(
                                "Cancel",
                                fontWeight: FontWeight.w500,
                                textColor: Palette.grey,
                                onTap: () => goBack(),
                              ),
                              3.h.verticalSpace,
                            ].separate(10.h.verticalSpace),
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
              ),
              ActivityBox(
                title: "Track your products",
                iconPath: Assets.flower,
                description:
                    "You can keep track of your products and let us notify you when they are about to expire.",
                onTap: () => goTo(ScanProductView.route),
              ),
            ].separate(kfsVeryTiny.horizontalSpace),
          ),
        ),
      ].separate(kfsMedium.verticalSpace),
    );
  }
}
