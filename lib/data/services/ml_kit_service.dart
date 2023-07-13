import 'dart:io';

import 'package:flutter/material.dart';
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

  Future<List<String>> getRecognizedText(File file) async {
    List<String> textsList = [];

    final inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          textsList.add(element.text);
        }
      }
    }

    await textRecognizer.close();
    return textsList;
  }
}
