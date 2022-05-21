import 'unit.dart';

class UnitConverterService {
  double convertValue(Unit baseUnit, Unit targetUnit, double valueToConvert) {
    if (baseUnit.dimension != targetUnit.dimension) {
      throw "Cannot convert between units of different dimension.";
    }

    double conversionFactorFromBaseToTarget =
        baseUnit.conversionFactorToBaseUnit /
            targetUnit.conversionFactorToBaseUnit;

    return valueToConvert * conversionFactorFromBaseToTarget;
  }
}
