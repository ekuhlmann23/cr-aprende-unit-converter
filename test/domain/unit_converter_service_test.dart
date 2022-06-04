import 'package:flutter_test/flutter_test.dart';
import 'package:unit_converter/domain/dimension.dart';
import 'package:unit_converter/domain/unit.dart';
import 'package:unit_converter/domain/unit_converter_service.dart';

void main() {
  test('Verificar que convertir a una misma unidad no cambia el valor', () {
    // Arrange (preparar / acomodar)
    final converterService = UnitConverterService();
    final meter = Unit('Meter', 'm', 1, Dimension('Distancia', 'Metro'));
    const valueToConvert = 10.0;

    // Act (acción que tomamos que queremos verificar)
    final result = converterService.convertValue(meter, meter, valueToConvert);

    // Assert (verificamos resultado)
    expect(result, valueToConvert,
        reason: 'Convertir de metro a metro no cambia el resultado.');
  });
}
