import 'dart:io';
import 'package:ebntz/const.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

final textRecognizerProvider = Provider<TextRecognizer>(
  (ref) => throw UnimplementedError(),
);

final mlKitServiceProvider = Provider(
  (ref) => MLKitService(
    ref.read(textRecognizerProvider),
  ),
);

class MLKitService {
  MLKitService(this.textRecognizer);

  final TextRecognizer textRecognizer;

  Future<List<String>> getRecognizedTextsList(File file) async {
    List<String> textsList = [];

    final inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        //for (TextElement element in line.elements) {
        textsList.add(line.text);
        //}
      }
    }

    await textRecognizer.close();
    return textsList;
  }

  // Future<String> getRecognizedTexts(File file) async {
  //   final inputImage = InputImage.fromFile(file);
  //   final RecognizedText recognizedText =
  //       await textRecognizer.processImage(inputImage);

  //   final regExp = RegExp(r'[^a-zA-Z0-9áéíóúÁÉÍÓÚñÑ]');

  //   final texts = recognizedText.text.replaceAll(regExp, '');

  //   await textRecognizer.close();
  //   return texts;
  // }

  Future<String?> getTitle(File file) async {
    String? result;
    double biggestTextSize = 0;
    double sumSize = 0;

    final inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        sumSize = line.boundingBox.size.height * line.boundingBox.size.width;
        if (sumSize > biggestTextSize && line.text.length < kMaxCharacters) {
          result = line.text;
          // print(result);
          // print(sumSize);
          biggestTextSize = sumSize;
        }
      }
    }

    await textRecognizer.close();
    return result;
  }
}
