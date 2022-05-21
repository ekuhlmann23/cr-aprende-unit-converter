import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unit_converter/domain/dimension.dart';
import 'package:unit_converter/domain/unit.dart';
import 'package:unit_converter/domain/unit_converter_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: UnitConverterPage(),
    );
  }
}

class UnitConverterPage extends StatefulWidget {
  UnitConverterPage({Key? key}) : super(key: key) {
    length = Dimension("Distance", "Meter");
    centimeter = Unit("Centimeter", "cm", 0.01, length);
    meter = Unit("Meter", "m", 1, length);
    unitConverter = UnitConverterService();
  }

  late Dimension length;
  late Unit centimeter;
  late Unit meter;
  late UnitConverterService unitConverter;

  @override
  State<UnitConverterPage> createState() => _UnitConverterPageState();
}

class _UnitConverterPageState extends State<UnitConverterPage> {
  double? valueToConvert;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Unit Converter')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'\d+([\.]\d*)?'))
                ],
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    valueToConvert = double.parse(value);
                  } else {
                    valueToConvert = null;
                  }
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (valueToConvert != null) {
                    double convertedValue = widget.unitConverter.convertValue(
                        widget.centimeter, widget.meter, valueToConvert!);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            '$valueToConvert${widget.centimeter.symbol} = $convertedValue${widget.meter.symbol}'),
                      ),
                    );
                  }
                },
                child: const Text("Convert"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
