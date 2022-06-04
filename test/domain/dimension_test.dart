import 'package:flutter_test/flutter_test.dart';
import 'package:unit_converter/domain/dimension.dart';

void main() {
  test('Probar igualdad', () {
    final dimension1 = Dimension('Distancia', 'Metro');
    final dimension2 = Dimension('Distancia', 'Metro');

    expect(dimension1, dimension2);
  });

  test('Probar no igualdades', () {
    final dimension1 = Dimension('Distancia', 'Metro');
    final dimension2 = Dimension('Distancia', 'Milla');

    expect(dimension1, isNot(dimension2));
  });
}
