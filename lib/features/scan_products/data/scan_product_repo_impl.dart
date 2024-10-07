import 'dart:convert';
import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

class ProductScannerRepositoryImpl implements ProductScannerRepository {
  final GenerativeModel _model;

  ProductScannerRepositoryImpl(this._model);

  @override
  Future<GemmaResponse?> scanProductImage(
    String imagePath,
    List<String> skinGoals,
  ) async {
    AppLogger.log("SKIN GOALS: $skinGoals");
    try {
      final file = File(imagePath);
      final bytes = await file.readAsBytes();

      final content = [
        Content.multi([
          TextPart("""This should be an image of a SkinCare product. 
        The image should contain the ingredients of the product. 
        Try and identify the ingredients of the product. 
        If you are able to identify it, your response should be in JSON format of this structure
        like this only. My skin care goal are ${skinGoals.toString()}.

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

      final response = await _model.generateContent(content);
      final text = response.text;

      if (text != null) {
        String jsonString =
            text.replaceAll('```json', '').replaceAll('```', '').trim();
        Map<String, dynamic> jsonObject = jsonDecode(jsonString);
        AppLogger.logWarning("JSON: $jsonString", tag: "scanProductImage");
        AppLogger.log("Gemme response: ${GemmaResponse.fromJson(jsonObject)}",
            tag: "scanProductImage");
        return GemmaResponse.fromJson(jsonObject);
      }
    } catch (e, s) {
      AppLogger.logError('Error scanning product image: $e $s');
      return GemmaResponse(
        status: 'error',
        code: 500,
        ingredients: [],
        suggestion: '',
      );
    }
    return null;
  }
}
