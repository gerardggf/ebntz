import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebntz/data/services/firebase_firestore_service.dart';
import 'package:ebntz/data/services/firebase_storage_service.dart';
import 'package:ebntz/data/services/ml_kit_service.dart';
import 'package:ebntz/my_app.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  runApp(
    ProviderScope(
      overrides: [
        firebaseStorageProvider.overrideWithValue(firebaseStorage),
        firebaseFirestoreProvider.overrideWithValue(firebaseFirestore),
        textRecognizerProvider.overrideWithValue(textRecognizer),
      ],
      child: const MyApp(),
    ),
  );
}
