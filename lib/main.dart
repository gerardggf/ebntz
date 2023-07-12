import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebntz/data/services/firebase_firestore_service.dart';
import 'package:ebntz/data/services/firebase_storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/modules/home/home_view.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;

  runApp(
    ProviderScope(
      overrides: [
        firebaseStorageProvider.overrideWithValue(firebaseStorage),
        firebaseFirestoreProvider.overrideWithValue(firebaseFirestore),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'eBntz',
        home: HomeView(),
      ),
    );
  }
}
