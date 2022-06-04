import 'package:flutter/material.dart';
import 'package:unit_converter/application/unit_converter_use_case.dart';
import 'package:unit_converter/infrastructure/dummy_unit_converter_repository.dart';
import 'package:unit_converter/presentation/unit_converter_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: UnitConverterPage(
          useCase: UnitConverterUseCase(DummyUnitConverterRepository())),
    );
  }
}
