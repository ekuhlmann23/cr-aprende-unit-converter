import 'package:unit_converter/domain/dimension.dart';
import 'package:unit_converter/domain/i_unit_converter_repository.dart';
import 'package:unit_converter/domain/unit.dart';
import 'package:unit_converter/domain/unit_converter_service.dart';

// Clean architecture, SOLID principles
class UnitConverterUseCase {
  final IUnitConverterRepository _repository;

  UnitConverterUseCase(IUnitConverterRepository repository)
      : _repository = repository;

  Future<Iterable<Dimension>> getAllDimensions() {
    return _repository.getAllDimensions();
  }

  Future<Iterable<Unit>> getAllUnitsForADimension(Dimension dimension) {
    return _repository.getAllUnitsForADimension(dimension);
  }

  double convertValue(Unit baseUnit, Unit targetUnit, double valueToConvert) {
    return UnitConverterService.convertValue(
        baseUnit, targetUnit, valueToConvert);
  }
}
