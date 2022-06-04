import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unit_converter/application/unit_converter_use_case.dart';
import 'package:unit_converter/infrastructure/dummy_unit_converter_repository.dart';
import 'package:unit_converter/infrastructure/firebase_unit_converter_repository.dart';
import 'package:unit_converter/presentation/unit_converter_page.dart';

import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: UnitConverterPage(
          useCase: UnitConverterUseCase(
              FirebaseUnitConverterRepository(FirebaseFirestore.instance))),
    );
  }
}
