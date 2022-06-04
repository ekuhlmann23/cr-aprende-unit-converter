import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unit_converter/application/unit_converter_use_case.dart';
import 'package:unit_converter/domain/dimension.dart';
import 'package:unit_converter/domain/unit.dart';

class UnitConverterPage extends StatefulWidget {
  final UnitConverterUseCase useCase;

  const UnitConverterPage({Key? key, required this.useCase}) : super(key: key);

  @override
  State<UnitConverterPage> createState() => _UnitConverterPageState();
}

class _UnitConverterPageState extends State<UnitConverterPage> {
  bool isLoading = true;
  Iterable<Dimension>? allDimensions;

  @override
  void initState() {
    super.initState();
    loadDimensions();
  }

  void loadDimensions() async {
    final dimensionsResult = await widget.useCase.getAllDimensions();
    setState(() {
      allDimensions = dimensionsResult;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Unit Converter')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : UnitConverterWidget(
                  useCase: widget.useCase,
                  allDimensions: allDimensions!,
                ),
        ),
      ),
    );
  }
}

class UnitConverterWidget extends StatefulWidget {
  final Iterable<Dimension> allDimensions;
  final UnitConverterUseCase useCase;

  const UnitConverterWidget(
      {Key? key, required this.allDimensions, required this.useCase})
      : super(key: key);

  @override
  State<UnitConverterWidget> createState() => _UnitConverterWidgetState();
}

class _UnitConverterWidgetState extends State<UnitConverterWidget> {
  bool isLoading = false;
  Iterable<Unit>? unitsForSelectedDimension;
  Dimension? selectedDimension;
  Unit? selectedBaseUnit;
  Unit? selectedTargetUnit;
  double? valueToConvert;
  double? conversionResult;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          const CircularProgressIndicator()
        else ...[
          DropdownButton<Dimension>(
            hint: const Text('Select a dimension'),
            value: selectedDimension,
            items: widget.allDimensions
                .map(
                  (dimension) => DropdownMenuItem<Dimension>(
                    value: dimension,
                    child: Text(dimension.name),
                  ),
                )
                .toList(),
            onChanged: (dimension) async {
              if (dimension != null) {
                setState(() {
                  isLoading = true;
                });

                final unitResults =
                    await widget.useCase.getAllUnitsForADimension(dimension);

                setState(() {
                  selectedDimension = dimension;
                  unitsForSelectedDimension = unitResults;
                  isLoading = false;
                });
              }
            },
          ),
          const SizedBox(height: 30),
          if (selectedDimension == null)
            const Text('No dimension selected')
          else if (unitsForSelectedDimension == null ||
              unitsForSelectedDimension!.isEmpty)
            const Text('There are no units for the selected dimension.')
          else ...[
            DropdownButton<Unit>(
              hint: const Text('Select a base unit'),
              value: selectedBaseUnit,
              items: unitsForSelectedDimension!
                  .map((unit) => DropdownMenuItem<Unit>(
                      value: unit, child: Text(unit.name)))
                  .toList(),
              onChanged: (baseUnit) {
                setState(() {
                  selectedBaseUnit = baseUnit;
                });
                convert();
              },
            ),
            const SizedBox(height: 15),
            DropdownButton<Unit>(
              hint: const Text('Select a target unit'),
              value: selectedTargetUnit,
              items: unitsForSelectedDimension!
                  .map((unit) => DropdownMenuItem<Unit>(
                      value: unit, child: Text(unit.name)))
                  .toList(),
              onChanged: (baseUnit) {
                setState(() {
                  selectedTargetUnit = baseUnit;
                });
                convert();
              },
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Type a value to convert',
                  suffix: selectedBaseUnit != null
                      ? Text(selectedBaseUnit!.symbol)
                      : null,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'\d+([\.]\d*)?'))
                ],
                onChanged: (value) {
                  late double? parsedValue;
                  if (value.isNotEmpty) {
                    parsedValue = double.parse(value);
                  } else {
                    parsedValue = null;
                  }
                  setState(() {
                    valueToConvert = parsedValue;
                  });
                  convert();
                },
              ),
            ),
            const SizedBox(height: 50),
            if (conversionResult != null)
              Text('Result: $conversionResult${selectedTargetUnit!.symbol}')
          ]
        ]
      ],
    );
  }

  void convert() {
    if (selectedBaseUnit != null &&
        selectedTargetUnit != null &&
        valueToConvert != null) {
      setState(() {
        conversionResult = widget.useCase.convertValue(
            selectedBaseUnit!, selectedTargetUnit!, valueToConvert!);
      });
    }
  }
}
