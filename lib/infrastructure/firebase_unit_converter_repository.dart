import 'package:unit_converter/domain/dimension.dart';
import 'package:unit_converter/domain/i_unit_converter_repository.dart';
import 'package:unit_converter/domain/unit.dart';

class FirebaseUnitConverterRepository implements IUnitConverterRepository {
  @override
  Future<Iterable<Dimension>> getAllDimensions() {
    // llamados a firebase
    throw UnimplementedError();
  }

  @override
  Future<Iterable<Unit>> getAllUnitsForADimension(Dimension dimension) {
    // llamados a firebase
    throw UnimplementedError();
  }
}
