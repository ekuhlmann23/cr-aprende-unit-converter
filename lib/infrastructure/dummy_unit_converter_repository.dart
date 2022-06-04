import 'package:unit_converter/domain/dimension.dart';
import 'package:unit_converter/domain/i_unit_converter_repository.dart';
import 'package:unit_converter/domain/unit.dart';

class DummyUnitConverterRepository implements IUnitConverterRepository {
  // Dimensions
  late final distance = Dimension("Distance", "Meter");
  late final mass = Dimension("Mass", "Gram");

  late final Iterable<Dimension> dimensions = [distance, mass];

  // Units
  late final centimeter = Unit("Centimeter", "cm", 0.01, distance);
  late final meter = Unit("Meter", "m", 1, distance);
  late final gram = Unit("Gram", "g", 1, mass);
  late final kilogram = Unit("Kilogram", "kg", 1000, mass);

  late final Iterable<Unit> units = [centimeter, meter, gram, kilogram];

  @override
  Future<Iterable<Dimension>> getAllDimensions() {
    return Future.value(dimensions);
  }

  @override
  Future<Iterable<Unit>> getAllUnitsForADimension(Dimension dimension) {
    return Future.value(units.where((u) => u.dimension == dimension));
  }
}
