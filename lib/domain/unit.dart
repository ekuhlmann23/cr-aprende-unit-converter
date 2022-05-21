import 'dimension.dart';

class Unit {
  final String name;
  final String symbol;
  final double conversionFactorToBaseUnit;
  final Dimension dimension;

  Unit(this.name, this.symbol, this.conversionFactorToBaseUnit, this.dimension);

  @override
  bool operator ==(Object other) {
    return other is Unit &&
        name == other.name &&
        symbol == other.symbol &&
        conversionFactorToBaseUnit == other.conversionFactorToBaseUnit &&
        dimension == other.dimension;
  }

  @override
  int get hashCode =>
      name.hashCode ^
      symbol.hashCode ^
      conversionFactorToBaseUnit.hashCode ^
      dimension.hashCode;
}
